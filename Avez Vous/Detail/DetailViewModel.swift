//
//  DetailViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation
import RealmSwift

final class DetailViewModel {
    
    var inputDetailPhoto: Observable<Photos?> = Observable(nil)
//    var inputLikePhoto: Observable<DBTable?> = Observable(nil)
    var inputLike: Observable<Photos?> = Observable(nil)
    
    var outputDetailPhoto: Observable<Photos?> = Observable(nil)
    var outputStatistics: Observable<PhotoStatistics?> = Observable(nil)
    var outputLike: Observable<Bool?> = Observable(nil)
    
    let realmrepository = RealmRepository()
    
    init() {
        
        inputDetailPhoto.bind { [weak self] value in
            guard let value else { return }
            self?.outputDetailPhoto.value = value
            self?.fetchData(imageID: value.id)
        }
        
        inputLike.bind { [weak self] value in
            guard let value else { return }
            self?.likeCheck(data: value)
        }
    }
    
    private func fetchData(imageID: String) {
        let router = RouterPattern.statistics(imageID: imageID)
        
        APIManager.shared.callRequest(router: router, responseType: PhotoStatistics.self) { response in
            switch response {
            case .success(let value):
                self.outputStatistics.value = value
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func likeCheck(data: Photos) {
        var like = UserInfo.shared.getLikeProduct(forkey: data.id)
        like.toggle()
        
        let task = DBTable(id: data.id, url: data.urls.small, likeCount: data.likes)
        
        if like {
            UserInfo.shared.setLikeProduct(isLike: like, forkey: data.id)
            realmrepository.createItem(task)
        } else {
            UserInfo.shared.setLikeProduct(isLike: like, forkey: data.id)
            realmrepository.deleteItem(task, id: data.id)
        }
        
        outputLike.value = like
    }

}
