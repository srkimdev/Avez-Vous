//
//  RandomPictureViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/28/24.
//

import Foundation
import RealmSwift

final class RandomPictureViewModel {
    
    var inputRandomImage: CustomObservable<Void?> = CustomObservable(nil)
    var inputLike: CustomObservable<Photos?> = CustomObservable(nil)
    
    var outputRandomImage: CustomObservable<[Photos]> = CustomObservable([])
    var outputLike: CustomObservable<Void?> = CustomObservable(nil)
    var scrollToTop: CustomObservable<Void?> = CustomObservable(nil)
    
    let realmrepository = RealmRepository()
    
    init() {
        inputRandomImage.bind { [weak self] value in
            guard let value else { return }
            
            self?.fetchData()
        }
        
        inputLike.bind { [weak self] value in
            guard let value else { return }
            
            self?.likeCheck(data: value)
        }
        
    }
    
    private func fetchData() {
        let router = RouterPattern.random
        
        APIManager.shared.callRequest(router: router, responseType: [Photos].self) { response in
            switch response {
            case .success(let value):
                self.outputRandomImage.value = value
                self.scrollToTop.value = ()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func likeCheck(data: Photos) {
        var like = UserInfo.shared.getLikeProduct(forkey: data.id)
        like.toggle()
        
        if like {
            let task = DBTable(id: data.id, created_at: data.created_at, width: data.width, height: data.height, urls: data.urls.small, likes: data.likes, writerName: data.user.name, writerImage: data.user.profile_image.medium, storeTime: Date())
            UserInfo.shared.setLikeProduct(isLike: like, forkey: data.id)
            realmrepository.createItem(task)
            
            FilesManager.shared.downloadImage(from: data.urls.small) { value in
                FilesManager.shared.saveImageToDocument(image: value!, filename: data.id)
            }
            
        } else {
            UserInfo.shared.setLikeProduct(isLike: like, forkey: data.id)
            realmrepository.deleteItem(id: data.id)
            
            FilesManager.shared.removeImageFromDocument(filename: data.id)
        }
        
        outputLike.value = ()
    }
    
}
