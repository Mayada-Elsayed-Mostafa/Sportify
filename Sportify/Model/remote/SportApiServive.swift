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
    
    
    func get<T: Decodable>(parameters: [String: Any], completion: @escaping (T?) -> Void) {
        AF.request(baseURL, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                debugPrint(response)
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print("Error fetching data: \(error)")
                    completion(nil)
                }
            }
    }
    
}
