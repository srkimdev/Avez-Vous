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
        static let start: String = "시작하기"
        static let save: String = "완료"
    }
    
    enum BorderWidths {
        static let Width3: CGFloat = 3
        static let Width1: CGFloat = 1
    }
    
    enum navigationTitle {
        static let profileSetting: String = "PROFILE SETTING"
        
        
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

enum validationError: String, Error {
    case isNotLength = "2글자 이상 10글자 미만으로 입력해주세요."
    case isNotAt = "닉네임에 @는 포함할 수 없어요."
    case isNotHash = "닉네임에 #는 포함할 수 없어요."
    case isNotDollar = "닉네임에 $는 포함할 수 없어요."
    case isNotPercent = "닉네임에 %는 포함할 수 없어요."
    case isNotNumber = "닉네임에 숫자는 포함할 수 없어요."
    case isNotSpace = "닉네임에 공백은 포함할 수 없어요."
}

