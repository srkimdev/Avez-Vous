//
//  UserInfo.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation

class UserInfo {
    
    static let shared = UserInfo()
    let userDefault = UserDefaults.standard
    
    private init() { }
    
    func getLikeProduct(forkey: String) -> Bool {
        return userDefault.bool(forKey: forkey)
    }
    
    func setLikeProduct(isLike: Bool, forkey: String) {
        userDefault.set(isLike, forKey: forkey)
    }
    
}
