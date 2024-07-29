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
        
        print(router)
        
        AF.request(router.endpoint,
                   method: router.method,
                   parameters: router.parameter,
                   headers: router.header
        ).responseDecodable(of: responseType) { response in
            switch response.result {
                
            case .success(let value):
                completionHandler(.success(value))

            case .failure:
                let statusCode: Int = response.response?.statusCode ?? 0
                let error = APIError.statusCodeCheck(statusCode: statusCode)
                print("error: \(error.description)")
            }
        }
    }
    
}
