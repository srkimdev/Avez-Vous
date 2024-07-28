//
//  RealmRepository.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation
import RealmSwift

final class RealmRepository {
    
    private let realm = try! Realm()
        
    func createItem(_ data: DBTable) {
        do {
            try! realm.write {
                realm.add(data)
                print("Realm Create Succeed")
            }
        } catch {
            print("Realm Error")
        }
    }

    func readAllItemASC() -> [DBTable] {
        let list = realm.objects(DBTable.self).sorted(byKeyPath: "storeTime", ascending: true)
        return Array(list)
    }
    
    func readAllItemDESC() -> [DBTable] {
        let list = realm.objects(DBTable.self).sorted(byKeyPath: "storeTime", ascending: false)
        return Array(list)
    }
    
    func deleteItem(id: String) {
        let filter = realm.objects(DBTable.self).first(where: {$0.id == id} )
        
        try! realm.write {
            realm.delete(filter!)
            print("Realm Delete Succeed")
        }
    }

    func detectRealmURL() {
        print(realm.configuration.fileURL)
    }
    
}
