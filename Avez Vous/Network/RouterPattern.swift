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
    case search(keyword: String, order: String, color: String)
    
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
        case .search(let keyword, let order, let color):
            return URL(string: baseURL + "search/photos?query=\(keyword)&page=1&per_page=20&order_by=\(order)&color=\(color)&" + baseKey)!
        }
        
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
