//
//  TeamDetailsPresenter.swift
//  Sportify
//
//  Created by Macos on 21/05/2025.
//

import Foundation


class TeamDetailsPresenter {
    
    private var vc:TeamDetailsViewController
    let playerTypes = ["Coach", "Goalkeepers", "Defenders", "Midfielders", "Forwards"]
    
    init(vc: TeamDetailsViewController) {
        self.vc = vc
    }
    
    func getTeamMembers(endPoint: String, teamId: Int){
        
        let parameters: [String: Any] = [
            "met": "Players",
            "APIkey": Constants.API_KEY,
            "teamId": teamId
        ]
        print(parameters)
        SportsApiService.shared.get(endPoint: endPoint, parameters: parameters) { [self]
            (response: PlayerResponse?) in
            
            
            if let players = response?.result {
                
                self.vc.sectionedPlayers = playerTypes.compactMap { type in
                    let filtered = players.filter { $0.playerType == type }
                    return filtered.isEmpty ? nil : (title: type, players: filtered)
                }
                
                DispatchQueue.main.async {
                    self.vc.tabelView.reloadData()
                }
                
            }else{
                
            }
        }
    }
    func groupPlayers(from players: [Player]) {

    }
}
