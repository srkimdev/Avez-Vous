//
//  PhotoStatistics.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation

struct PhotoStatistics: Decodable {
    let id: String
    let downloads: Download
    let views: Views
}

struct Download: Decodable {
    let total: Int
    let historical: Historical
}

struct Views: Decodable {
    let total: Int
    let historical: Historical
}

struct Historical: Decodable {
    let values: [Value]
}

struct Value: Decodable {
    let date: String
    let value: Int
}


