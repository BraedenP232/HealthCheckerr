import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private var dockerHost: String = "http://192.168.1.55:2375" // Default Docker host
    
    func setDockerHost(ipAddress: String) {
        dockerHost = "http://\(ipAddress):2375"
    }
    
    func fetchDockerData(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(dockerHost)\(endpoint)") else {
            completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 2, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            completion(.success(data))
        }.resume()
    }
    func sendDockerAction(containerID: String, action: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(dockerHost)/containers/\(containerID)/\(action)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 {
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Action failed."])))
            }
        }.resume()
    }
}
