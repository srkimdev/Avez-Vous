//
//  SearchPhoto.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import Foundation

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

