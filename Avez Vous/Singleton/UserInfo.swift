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
    
    var userName: String {
        get {
            return userDefault.string(forKey: "userName") ?? "DefaultUser"
        }
        set {
            userDefault.set(newValue, forKey: "userName")
        }
    }
    
    var profileNumber: Int {
        get {
            return userDefault.integer(forKey: "profileNumber")
        }
        set {
            userDefault.set(newValue, forKey: "profileNumber")
        }
    }
    
    var MBTI: [Int] {
        get {
            userDefault.array(forKey: "MBTI") as? [Int] ?? []
        }
        set {
            userDefault.set(newValue, forKey: "MBTI")
        }
    }
    
    func getLikeProduct(forkey: String) -> Bool {
        return userDefault.bool(forKey: forkey)
    }
    
    func setLikeProduct(isLike: Bool, forkey: String) {
        userDefault.set(isLike, forKey: forkey)
    }
    
}
