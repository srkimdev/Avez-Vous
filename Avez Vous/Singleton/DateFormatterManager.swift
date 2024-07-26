//
//  DateFormatterManager.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation

final class DateFormatterManager {
    
    static let shared = DateFormatterManager()
    
    private init() { }
    
    func changeDate(_ date: String) -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let changeToDate = format.date(from: date)
        
        format.dateFormat = "yyyy년 M월 d일"
        let changeToString = format.string(from: changeToDate!)
        
        return changeToString
    }
}
