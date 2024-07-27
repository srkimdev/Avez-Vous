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

