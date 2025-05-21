//
//  Player.swift
//  Sportify
//
//  Created by Macos on 21/05/2025.
//

import Foundation

struct PlayerResponse: Codable {
    let success: Int
    let result: [Player]
}

struct Player: Codable {
    let playerName: String
    let playerImage: String?
    let playerType: String

 
    private enum CodingKeys: String, CodingKey {
        case playerName = "player_name"
        case playerImage = "player_image"
        case playerType = "player_type"
    }
}
