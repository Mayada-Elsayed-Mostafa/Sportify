//
//  SportApiServive.swift
//  Sportify
//
//  Created by Macos on 13/05/2025.
//

import Foundation

import Alamofire

class SportsApiService {
    static let shared = SportsApiService()
    private let baseURL = "https://apiv2.allsportsapi.com/football/"
    private let API_KEY = "1a8e51d71f90f74c2d3240fb0e5e56ba7138dead785f3e8abcd03a3925888c23"
    
    func getLeagues(completion: @escaping ([League]?) -> Void) {
        
        let url = "\(baseURL)/all_leagues.php"
        
        let parameters: [String: Any] = [
            "met": "Leagues",
            "APIkey": API_KEY
        ]
        
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: LeaguesResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(data.result)
                case .failure(let error):
                    print("Error fetching leagues: \(error)")
                    completion(nil)
                }
            }
    }
    
}
