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
        static let trend: UIImage = UIImage(named: "tab_trend")!
        static let trendInactive: UIImage = UIImage(named: "tab_trend_inactive")!
        static let random: UIImage = UIImage(named: "tab_random")!
        static let randomInactive: UIImage = UIImage(named: "tab_random_inactive")!
        static let search: UIImage = UIImage(named: "tab_search")!
        static let searchInactive: UIImage = UIImage(named: "tab_search_inactive")!
        static let tabLike: UIImage = UIImage(named: "tab_like")!
        static let tabLikeInactive: UIImage = UIImage(named: "tab_like_inactive")!
    }
    
    enum Buttons {
        static let start: String = "시작하기"
        static let clear: String = "완료"
        static let latest: String = "최신순"
        static let relavant: String = "관련순"
        static let past: String = "과거순"
        static let save: String = "저장"
        static let quit: String = "회원탈퇴"
    }
    
    enum BorderWidths {
        static let Width3: CGFloat = 3
        static let Width1: CGFloat = 1
    }
    
    enum Alpha {
        static let alphaHalf: CGFloat = 0.5
        static let alphaOne: CGFloat = 1
    }
    
    enum NavigationTitle {
        static let profileSetting: String = "PROFILE SETTING"
        static let profileSelecting: String = "EDIT PROFILE"
        static let searchPhoto: String = "SEARCH PHOTO"
        static let likestore: String = "MY POLAROID"
    }
    
    enum ToastMessage {
        static let noConnected: String = "인터넷에 연결되지 않았습니다.\n연결 확인 후 다시 시도해 주세요."
    }
    
    enum AlertMessage {
        static let quit: String = "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?"
    }
    
    enum Name {
        static let appName: String = "Avez Vous"
        static let userName: String = "김성률"
        static let mbti: String = "MBTI"
        static let topic: String = "OUR TOPIC"
        static let information: String = "정보"
        static let size: String = "크기"
        static let seeCount: String = "조회수"
        static let download: String = "다운로드"
    }
    
    enum Placeholder {
        static let nickname: String = "닉네임을 입력해주세요 :)"
        static let noStore: String = "저장된 사진이 없어요"
        static let noSearch: String = "검색 결과가 없어요."
        static let search: String = "사진을 검색해보세요."
    }
    
}


