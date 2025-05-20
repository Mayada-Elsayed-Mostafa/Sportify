import Foundation

struct Team: Codable {
    let strTeam: String?
    let strTeamBadge: String?

    enum CodingKeys: String, CodingKey {
        case strTeam = "team_name"
        case strTeamBadge = "team_logo"
    }
}

struct TeamResponse: Decodable {
    let success: Int
    let result: [Team]
}
