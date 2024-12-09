import Foundation

struct DockerContainer: Codable, Identifiable {
    let id: String
    let names: [String]
    let state: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case names = "Names"
        case state = "State"
        case status = "Status"
    }
    var formattedName: String {
        names.first?.replacingOccurrences(of: "/", with: "").capitalized ?? "Unnamed"
    }
}
