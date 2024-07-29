//
//  Observable.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import Foundation

final class Observable<T> {
    
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
    
    deinit {
//        print(value)
    }
    
}
