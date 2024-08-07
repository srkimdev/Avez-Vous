//
//  ProfileSelectingViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import Foundation

final class ProfileSelectingViewModel {
    
    var inputSelectedImage: CustomObservable<Int> = CustomObservable(-1)
    var outputSelectedImage: CustomObservable<Int> = CustomObservable(-1)
    
    init() {
        inputSelectedImage.bind { [weak self] value in
            self?.outputSelectedImage.value = value
        }
    }

}
