//
//  LeagueDetailsPresenter.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

class LeagueDetailsPresenter {
    weak var vc: LeagueDetailsCollectionViewController?
    var fixtures: [Fixture]?
    var teams: [Team]?

    init(vc: LeagueDetailsCollectionViewController?) {
        self.vc = vc
    }

    func getFixtures(endPoint: String) {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: currentDate)

        var formattedFutureDate: String = ""
        if let futureDate = Calendar.current.date(byAdding: .day, value: 3, to: currentDate) {
            formattedFutureDate = formatter.string(from: futureDate)
        }

        let parameters: [String: Any] = [
            "met": "Fixtures",
            "APIkey": Constants.API_KEY,
            "from": formattedDate,
            "to": formattedFutureDate
        ]

        print("Fetching fixtures from \(formattedDate) to \(formattedFutureDate) with endpoint: \(endPoint)")

        SportsApiService.shared.get(endPoint: endPoint, parameters: parameters) { (response: FixtureResponse?) in
            if let fixtures = response?.result {
                self.fixtures = fixtures
                print("Fixtures count fetched: \(fixtures.count)")
                DispatchQueue.main.async {
                    self.vc?.collectionView.reloadData()
                }
            } else {
                print("Failed to fetch fixtures")
            }
        }
    }

    func getTeams(endPoint: String) {
        let parameters: [String: Any] = [
            "met": "Teams",  
            "APIkey": Constants.API_KEY
        ]

        SportsApiService.shared.get(endPoint: endPoint, parameters: parameters) { (response: TeamResponse?) in
            if let teams = response?.result {
                self.teams = teams
                print("Teams count fetched: \(teams.count)")
                DispatchQueue.main.async {
                    self.vc?.collectionView.reloadData()
                }
            } else {
                print("Failed to fetch teams")
            }
        }
    }


    func getLatest(endPoint: String){
        let parameters: [String: Any] = [
            "met": "Leagues",
            "APIkey": Constants.API_KEY,
            "from": "2025-05-15",
            "to": "2025-05-18"
        ]

        SportsApiService.shared.get(endPoint: endPoint, parameters: parameters) { (response: FixtureResponse?) in
            if let fixtures = response?.result {
                debugPrint(fixtures)
            } else {
                print("Failed to fetch leagues")
            }
        }
    }
}
