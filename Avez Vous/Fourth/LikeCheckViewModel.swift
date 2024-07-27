//
//  LikeCheckViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation
import RealmSwift

class LikeCheckViewModel {
    
    var inputLike: Observable<DBTable?> = Observable(nil)
    var inputColor: Observable<SearchColor> = Observable(.black)
    var showLikeList: Observable<Void?> = Observable(nil)
    
    var outputResult: Observable<[DBTable]> = Observable([])
    
    let realmrepository = RealmRepository()
    var realmToDummy: DBTable?
    
    init() {
        showLikeList.bind { [weak self] _ in
            self?.outputResult.value = self?.realmrepository.readAllItem() ?? []
        }
        
        inputLike.bind { [weak self] value in
            guard let value else { return }
            self?.likeCheck(data: value)
        }
        
    }
    
    private func likeCheck(data: DBTable) {
        UserInfo.shared.setLikeProduct(isLike: false, forkey: data.id)
        realmrepository.deleteItem(id: data.id)
        showLikeList.value = ()
        NotificationCenter.default.post(name: NSNotification.Name("update"), object: nil, userInfo: nil)
    }
    
}
