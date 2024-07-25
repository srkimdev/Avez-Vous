//
//  SearchPhoto.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import Foundation
import UIKit

struct SearchPhotoTotal: Decodable {
    let total: Int
    let results: [SearchPhoto]
}

struct SearchPhoto: Decodable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let urls: SearchUrlSize
    let likes: Int
    let user: SearchUserInfo
}

struct SearchUrlSize: Decodable {
    let raw: String
    let small: String
}

struct SearchUserInfo: Decodable {
    let name: String
    let profile_image: SearchProfileSize
}

struct SearchProfileSize: Decodable {
    let medium: String
}

enum SearchOrder: String {
    case latest
    case relevant
    
    var title: String {
        switch self {
        case .latest:
            return "최신순"
        case .relevant:
            return "관련순"
        }
    }
}

enum SearchColor: String, CaseIterable {
    case black
    case white
    case yellow
    case red
    case purple
    case green
    case blue
    
    var color: UIColor {
        switch self {
        case .black:
            return UIColor.black
        case .white:
            return UIColor.white
        case .yellow:
            return UIColor.yellow
        case .red:
            return UIColor.red
        case .purple:
            return UIColor.purple
        case .green:
            return UIColor.green
        case .blue:
            return UIColor.blue
        }
    }
}

