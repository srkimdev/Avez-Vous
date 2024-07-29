//
//  Enums.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import Foundation

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

enum Mode: String {
    case setup
    case edit
}

