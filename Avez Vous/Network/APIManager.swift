//
//  APIManager.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import Foundation
import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func callRequest<T: Decodable>(router: RouterPattern, responseType: T.Type, completionHandler: @escaping (Result<T, APIError>) -> Void) {
        
        print(router.endpoint)
        AF.request(router.endpoint, method: router.method).responseDecodable(of: responseType) { response in
            switch response.result {
                
            case .success(let value):
                completionHandler(.success(value))
                
            case .failure(let error):
                print(error)
//                if let data = response.data,
//                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                   let errorCode = json["errorCode"] as? String {
//                    let apiError = APIError.from(errorCode: errorCode)
//                    completionHandler(.failure(apiError))
//                } else {
//                    let statusCode = response.response?.statusCode ?? -1
//                    let apiError = APIError.from(errorCode: "statusCode: \(statusCode)")
//                    completionHandler(.failure(apiError))
//                }
            }
        }
    }
    
}
