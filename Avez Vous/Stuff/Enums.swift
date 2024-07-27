//
//  Enums.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import Foundation

enum validationError: String, Error {
    case isNotLength = "2글자 이상 10글자 미만으로 입력해주세요."
    case isNotAt = "닉네임에 @는 포함할 수 없어요."
    case isNotHash = "닉네임에 #는 포함할 수 없어요."
    case isNotDollar = "닉네임에 $는 포함할 수 없어요."
    case isNotPercent = "닉네임에 %는 포함할 수 없어요."
    case isNotNumber = "닉네임에 숫자는 포함할 수 없어요."
    case isNotSpace = "닉네임에 공백은 포함할 수 없어요."
}

enum MBTI: String, CaseIterable {
    case E
    case S
    case T
    case J
    case I
    case N
    case F
    case P
}

enum profileImages: Int, CaseIterable {
    case profile_0 = 0
    case profile_1
    case profile_2
    case profile_3
    case profile_4
    case profile_5
    case profile_6
    case profile_7
    case profile_8
    case profile_9
    case profile_10
    case profile_11
}

struct Section {
    let title: String
    let query: String
}

enum Mode: String {
    case setup
    case edit
}

enum Topic: String, CaseIterable {
    case architecture = "architecture-interior"
    case goldenHour = "golden-hour"
    case wallpapers = "wallpapers"
    case nature
    case renders = "3d-renders"
    case travel
    case texturesPattern = "textures-patterns"
    case streetPhotography = "street-photography"
    case film
    case archival
    case experimental
    case animals
    case fashionBeauty = "fashion-beauty"
    case people
    case buisinessWork = "business-work"
    case foodDrink = "food-drink"
    
    var description: String {
        switch self {
        case .architecture:
            return "건축 및 인테리어"
        case .goldenHour:
            return "골든 아워"
        case .wallpapers:
            return "배경 화면"
        case .nature:
            return "자연"
        case .renders:
            return "3D 렌더링"
        case .travel:
            return "여행하다"
        case .texturesPattern:
            return "텍스쳐 및 패턴"
        case .streetPhotography:
            return "거리 사진"
        case .film:
            return "필름"
        case .archival:
            return "기록의"
        case .experimental:
            return "실험적인"
        case .animals:
            return "동물"
        case .fashionBeauty:
            return "패션 및 뷰티"
        case .people:
            return "사람"
        case .buisinessWork:
            return "비즈니스 및 업무"
        case .foodDrink:
            return "식음료"
        }
    }
    
    static func randomCases() -> [Topic] {
        let topicArray = Topic.allCases
        let shuffled = topicArray.shuffled()
        return Array(shuffled.prefix(3))
    }
}
