//
//  RouterPattern.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import Foundation
import Alamofire

enum RouterPattern {
    
    case topic(topicID: String)
    
    var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var baseKey: String {
        return "client_id=\(APIKey.Id)"
    }
    
    var endpoint: URL {
        switch self {
        case .topic(let topicID):
            return URL(string: baseURL + "topics/\(topicID)/photos?page=1&" + baseKey)!
        }
        
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
