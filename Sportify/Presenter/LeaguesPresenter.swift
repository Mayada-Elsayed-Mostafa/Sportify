//
//  LeaguesPresenter.swift
//  Sportify
//
//  Created by Macos on 14/05/2025.
//

import Foundation


class LeaguesPresenter {
    var vc: LeaguesViewController?
    var leagues: [League]?
    
    init(vc: LeaguesViewController) {
        self.vc = vc
    }

    func getLeagues(){
    
        let parameters: [String: Any] = [
            "met": "Leagues",
            "APIkey": Constants.API_KEY
        ]
        
        SportsApiService.shared.get(parameters: parameters) { (response: LeaguesResponse?) in
            if let leagues = response?.result {
                
                let first100 = Array(leagues.prefix(100))
                let withLogos = first100.dropFirst().filter { $0.leagueLogo != nil && !$0.leagueLogo!.isEmpty
                }

                self.vc?.leagues = withLogos
                
                DispatchQueue.main.async {
                    self.vc?.leaguesTableView.reloadData()
                }
            } else {
                print("Failed to fetch leagues")
            }
        }
    }

}
