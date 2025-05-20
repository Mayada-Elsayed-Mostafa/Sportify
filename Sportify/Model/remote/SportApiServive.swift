import Foundation

import Alamofire


class SportsApiService {
    static let shared = SportsApiService()
    private let baseURL = "https://apiv2.allsportsapi.com/"
    
    func get<T: Decodable>(endPoint: String, parameters: [String: Any], completion: @escaping (T?) -> Void) {
        
        let url = baseURL + "\(endPoint)/"
        print(url)
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                
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
