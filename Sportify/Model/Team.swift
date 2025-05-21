import Foundation

struct Team: Codable {
    let strTeam: String?
    let strTeamBadge: String?
    let teamKey: Int?
    
    enum CodingKeys: String, CodingKey {
        case strTeam = "team_name"
        case strTeamBadge = "team_logo"
        case teamKey = "team_key"
    }
}

struct TeamResponse: Decodable {
    let success: Int
    let result: [Team]
}
