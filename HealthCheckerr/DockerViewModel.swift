import Foundation
class DockerViewModel: ObservableObject {
    @Published var containers: [DockerContainer] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private var ipAddress: String = ""

    func setIPAddress(_ ip: String) {
        ipAddress = ip
    }

    func fetchContainers() {
        isLoading = true
        errorMessage = nil
        containers = [] // Clear old data

        NetworkManager.shared.fetchDockerData(endpoint: "/containers/json?all=true") { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let data):
                    do {
                        let containers = try JSONDecoder().decode([DockerContainer].self, from: data)
                        self?.containers = containers
                    } catch {
                        self?.errorMessage = "Failed to parse data"
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    func performAction(on containerID: String, action: String) {
        NetworkManager.shared.sendDockerAction(containerID: containerID, action: action) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.fetchContainers() // Refresh container state after action
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
