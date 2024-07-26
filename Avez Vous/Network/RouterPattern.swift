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
    case search(keyword: String, page: Int, order: SearchOrder, color: SearchColor)
    case statistics(imageID: String)
    
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
        case .search(let keyword, let page, let order, let color):
            return URL(string: baseURL + "search/photos?query=\(keyword)&page=\(page)&per_page=20&order_by=\(order.rawValue)&color=\(color.rawValue)&" + baseKey)!
        case .statistics(let imageID):
            return URL(string: baseURL + "photos/\(imageID)/statistics?&" + baseKey)!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
}
