//
//  LeaguesPresenter.swift
//  Sportify
//
//  Created by Macos on 14/05/2025.
//

import Foundation


class LeaguesPresenter {
    private var vc: LeaguesViewController?
    var leagues: [League]?
    private var localSource: LeagueLocalSourceProtocol?
    
    init(vc: LeaguesViewController, localSource: LeagueLocalSourceProtocol) {
        self.vc = vc
        self.localSource = localSource
    }

    func getLeagues(endPoint: String){
    
        let parameters: [String: Any] = [
            "met": "Leagues",
            "APIkey": Constants.API_KEY
        ]
        
        SportsApiService.shared.get(endPoint: endPoint,parameters: parameters) { (response: LeaguesResponse?) in
            if let leagues = response?.result {
                let first100 = Array(leagues.prefix(100))
                
                if(endPoint == Constants.FOOTBALL){
                    let withLogos = first100.dropFirst().filter { $0.leagueLogo != nil && !$0.leagueLogo!.isEmpty
                    }
                    self.vc?.leagues = withLogos
                }else{
                    self.vc?.leagues = first100
                }

                DispatchQueue.main.async {
                    self.vc?.leaguesTableView.reloadData()
                }
            } else {
                print("Failed to fetch leagues")
            }
        }		
    }
    
    func saveLeagueToCoreData(league: League) -> Result<Void, Error> {
        return localSource?.insertLeague(league: league) ??  .failure(NSError(domain: "App", code: 0, userInfo: [NSLocalizedDescriptionKey: "Source is unavailable"]))
    }

}
