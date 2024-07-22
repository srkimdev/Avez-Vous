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
    }
    
    enum Images {
        static let launchImage: UIImage = UIImage(named: "launchImage")!
        static let Camera: UIImage = UIImage(systemName: "camera.fill")!
        static let Star: UIImage = UIImage(systemName: "star.fill")!
    }
    
    enum Buttons {
        static let startButton: String = "시작하기"
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

enum TransitionStyle {
    case present
    case presentNavigation
    case presentFullNavigation
    case push
}
