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
    case search(keyword: String, page: Int, order: SearchOrder, color: SearchColor?)
    case statistics(imageID: String)
    
    var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.Id]
    }
    
    var endpoint: String {
        switch self {
        case .topic(let topicID):
            return baseURL + "topics/\(topicID)/photos?page=1"
        case .search(let keyword, let page, let order, let color):
            return baseURL + "search/photos"
        case .statistics(let imageID):
            return baseURL + "photos/\(imageID)/statistics?"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .topic(let topicID):
            return nil
        case .search(let keyword, let page, let order_by, let color):
            var parameters: Parameters = [
                "query": keyword,
                "page": page,
                "per_page": 20,
                "order_by": order_by.rawValue
            ]
            if let color = color {
                parameters["color"] = color.rawValue
            }
            return parameters
        case .statistics(let imageID):
            return nil
        }
    }

    var method: HTTPMethod {
        return .get
    }
    
}
