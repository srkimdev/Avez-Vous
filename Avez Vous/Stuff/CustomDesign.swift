//
//  CustomDesign.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import UIKit

enum CustomDesign {
    
    enum Colors {
        static let Black: UIColor = UIColor(hex: "000000")
        static let White: UIColor = UIColor(hex: "FFFFFF")
        static let Red: UIColor = UIColor(hex: "F04452")
        static let Blue: UIColor = UIColor(hex: "186FF2")
        static let Gray: UIColor = UIColor(hex: "8C8C8C")
        static let DarkGray: UIColor = UIColor(hex: "4D5652")
        static let LightGray: UIColor = UIColor(hex: "F2F2F2")
        static let star: UIColor = #colorLiteral(red: 0.9993863702, green: 0.8329697847, blue: 0.3872109652, alpha: 1)
    }
    
    enum Images {
        static let placeholderImage: UIImage = UIImage(named: "placeholderImage")!
        static let launchImage: UIImage = UIImage(named: "launchImage")!
        static let camera: UIImage = UIImage(systemName: "camera.fill")!
        static let star: UIImage = UIImage(systemName: "star.fill")!
        static let likeCircleActive: UIImage = UIImage(named: "like_circle")!
        static let likeCircleInactive: UIImage = UIImage(named: "like_circle_inactive")!
        static let likeActive: UIImage = UIImage(named: "like")!
        static let likeInactive: UIImage = UIImage(named: "like_inactive")!
        static let sort: UIImage = UIImage(named: "sort")!
    }
    
    enum Buttons {
        static let start: String = "시작하기"
        static let save: String = "완료"
    }
    
    enum BorderWidths {
        static let Width3: CGFloat = 3
        static let Width1: CGFloat = 1
    }
    
    enum Alpha {
        static let alphaHalf: CGFloat = 0.5
        static let alphaOne: CGFloat = 1
    }
    
    enum navigationTitle {
        static let profileSetting: String = "PROFILE SETTING"
        static let profileSelecting: String = "EDIT PROFILE"
        static let searchPhoto: String = "SEARCH PHOTO"
    }
    
}

enum Literal {
    
    enum onBoarding {
        static let appName: String = "Avez Vous"
        static let userName: String = "김성률"
    }
    
    enum profileSetting {
        
    }
    
    
}

