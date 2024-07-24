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
    let urls: TopicUrlSize
    let likes: Int
    let user: TopicUserInfo
}

struct TopicUrlSize: Decodable {
    let raw: String
    let small: String
}

struct TopicUserInfo: Decodable {
    let name: String
    let profile_image: TopicProfileSize
}

struct TopicProfileSize: Decodable {
    let medium: String
}
