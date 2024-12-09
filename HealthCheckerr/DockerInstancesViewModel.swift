import Foundation

extension DockerInstancesViewModel {
    func fetchStatus(for instance: DockerInstance) async {
        guard let ipAddress = instance.ipAddress else { return }
        guard let instanceId = instance.id else {
            print("Error: Instance has no valid UUID.")
            return
        }

        let urlString = "http://\(ipAddress):2375/containers/json?all=true"
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let containers = try? JSONDecoder().decode([DockerContainer].self, from: data) {
                let runningCount = containers.filter { $0.state == "running" }.count
                let exitedCount = containers.filter { $0.state == "exited" }.count

                DispatchQueue.main.async {
                    self.instanceStatuses[instanceId] = DockerInstanceStatus(running: runningCount, exited: exitedCount)
                }
            }
        } catch {
            print("Error fetching status for \(ipAddress): \(error)")
        }
    }

    func fetchStatuses() async {
        for instance in dockerInstances {
            await fetchStatus(for: instance)
        }
    }
}

struct DockerInstanceStatus: Identifiable {
    let id: UUID
    var running: Int
    var exited: Int

    init(id: UUID = UUID(), running: Int, exited: Int) {
        self.id = id
        self.running = running
        self.exited = exited
    }
}

class DockerInstancesViewModel: ObservableObject {
    @Published var dockerInstances: [DockerInstance] = []
    @Published var instanceStatuses: [UUID: DockerInstanceStatus] = [:]

    init() {
        loadInstances()
    }

    func loadInstances() {
        dockerInstances = CoreDataManager.shared.fetchDockerInstances()
    }

    func addInstance(nickname: String, ipAddress: String) {
        CoreDataManager.shared.saveDockerInstance(nickname: nickname, ipAddress: ipAddress)
        loadInstances()
    }

    func removeInstance(_ instance: DockerInstance) {
        CoreDataManager.shared.deleteDockerInstance(instance)
        loadInstances()
    }
}
