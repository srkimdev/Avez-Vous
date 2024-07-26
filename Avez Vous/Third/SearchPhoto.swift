//
//  SearchPhoto.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import UIKit

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

