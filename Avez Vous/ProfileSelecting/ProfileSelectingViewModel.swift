//
//  ProfileSelectingViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import Foundation

final class ProfileSelectingViewModel {
    
    var inputSelectedImage: Observable<Int> = Observable(0)
    var outputSelectedImage: Observable<Int> = Observable(0)
    
    init() {
        inputSelectedImage.bind { value in
            self.outputSelectedImage.value = value
        }
    }

}
