import Foundation

struct Team: Codable {
    let strTeam: String?
    let strTeamBadge: String?
}

struct TeamResponse: Decodable {
    let success: Int
    let result: [Team]
}
