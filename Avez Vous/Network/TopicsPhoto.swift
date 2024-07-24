//
//  TopicsPhoto.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import Foundation

struct TopicsPhoto: Decodable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let urls: urlSize
    let likes: Int
    let user: userInfo
}

struct urlSize: Decodable {
    let raw: String
    let small: String
}

struct userInfo: Decodable {
    let name: String
    let profile_image: profileSize
}

struct profileSize: Decodable {
    let medium: String
}
