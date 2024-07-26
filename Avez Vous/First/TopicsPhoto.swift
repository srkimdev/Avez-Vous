//
//  TopicsPhoto.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import Foundation

struct PhotoTotal: Decodable {
    let total: Int
    let results: [Photos]
}

struct Photos: Decodable {
    let id: String
    let created_at: String
    let width: Int
    let height: Int
    let urls: UrlSize
    let likes: Int
    let user: WriterInfo
}

struct UrlSize: Decodable {
    let raw: String
    let small: String
}

struct WriterInfo: Decodable {
    let name: String
    let profile_image: ProfileSize
}

struct ProfileSize: Decodable {
    let medium: String
}
