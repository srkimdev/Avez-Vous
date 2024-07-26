//
//  DBTable.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation
import RealmSwift

class DBTable: Object {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var url: String
    @Persisted var likeCount: Int
    
    convenience init(id: String, url: String, likeCount: Int) {
        self.init()
        self.id = id
        self.url = url
        self.likeCount = likeCount
    }
    
}
