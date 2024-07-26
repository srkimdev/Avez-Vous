//
//  LikeCheckViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation
import RealmSwift

class LikeCheckViewModel {
    
    var inputColor: Observable<SearchColor> = Observable(.black)
    var showLikeList: Observable<Void?> = Observable(nil)
    
    var outputResult: Observable<[DBTable]> = Observable([])
    
    let realmrepository = RealmRepository()
    
    init() {
        showLikeList.bind { [weak self] _ in
            self?.outputResult.value = self?.realmrepository.readAllItem() ?? []
        }
    }
    
}
