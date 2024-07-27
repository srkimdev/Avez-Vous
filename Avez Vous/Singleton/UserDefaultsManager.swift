//
//  UserDefaultsManager.swift
//  Avez Vous
//
//  Created by 김성률 on 7/27/24.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()

    private init() { }
    
    var mode: String {
        get {
            return UserDefaults.standard.string(forKey: "mode") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "mode")
        }
    }
        
    
}
