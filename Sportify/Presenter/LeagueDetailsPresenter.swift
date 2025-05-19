//
//  LeagueDetailsPresenter.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

class LeagueDetailsPresenter {
    var vc: LeagueDetailsCollectionViewController?
    var fixtures: [Fixture]?
    
    
    init(vc: LeagueDetailsCollectionViewController?) {
        self.vc = vc
    }
    
    
    func getFixtures(endPoint: String){
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: currentDate)

        var formattedFutureDate: String = ""

        if let futureDate = Calendar.current.date(byAdding: .day, value: 3, to: currentDate) {
            formattedFutureDate = formatter.string(from: futureDate)
            print("3 days later: \(formattedFutureDate)")
        }

        let parameters: [String: Any] = [
            "met": "Fixtures",
            "APIkey": Constants.API_KEY,
            "from": formattedDate,
            "to": formattedFutureDate
        ]

        
        SportsApiService.shared.get(endPoint: endPoint, parameters: parameters){
            (response: FixtureResponse?) in
            
            if let fixtures = response?.result {
                debugPrint(fixtures[0])
            } else {
                print("Failed to fetch leagues")
            }
        }
    }
    
    func getLatest(endPoint: String){
        
        let parameters: [String: Any] = [
            "met": "Leagues",
            "APIkey": Constants.API_KEY,
            "from": "2025-05-19",
            "to":"2025-05-21"
        ]
        
        SportsApiService.shared.get(endPoint: endPoint, parameters: parameters){
            (response: FixtureResponse?) in
            
            if let fixtures = response?.result {
                debugPrint(fixtures)
            } else {
                print("Failed to fetch leagues")
            }
        }
    }
    
}
