//
//  DBTable.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation
import RealmSwift

class DBTable: Object {
    
    @Persisted(primaryKey: true) var key: ObjectId
    @Persisted var id: String
    @Persisted var created_at: String
    @Persisted var width: Int
    @Persisted var height: Int
    @Persisted var urls: String
    @Persisted var likes: Int
    @Persisted var writerName: String
    @Persisted var writerImage: String
    @Persisted var storeTime: Date
    
    convenience init(id: String, created_at: String, width: Int, height: Int, urls: String, likes: Int, writerName: String, writerImage: String, storeTime: Date) {
        self.init()
        self.id = id
        self.created_at = created_at
        self.width = width
        self.height = height
        self.urls = urls
        self.likes = likes
        self.writerName = writerName
        self.writerImage = writerImage
        self.storeTime = storeTime
    }
    
}
