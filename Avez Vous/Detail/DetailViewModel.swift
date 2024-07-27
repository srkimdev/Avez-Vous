//
//  DetailViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation
import RealmSwift

final class DetailViewModel {
    
    var inputFromSearch: Observable<Photos?> = Observable(nil)
    var inputFromLike: Observable<DBTable?> = Observable(nil)
    var inputLike: Observable<Photos?> = Observable(nil)
    
    var outputDetailPhoto: Observable<Photos?> = Observable(nil)
    var outputStatistics: Observable<PhotoStatistics?> = Observable(nil)
    var outputLike: Observable<Bool?> = Observable(nil)
    
    let realmrepository = RealmRepository()
    
    init() {
        
        inputFromSearch.bind { [weak self] value in
            guard let value else { return }
            self?.outputDetailPhoto.value = value
            self?.fetchData(imageID: value.id)
        }
        
        inputFromLike.bind { [weak self] value in
            guard let value else { return }
            self?.outputDetailPhoto.value = self?.toPhotos(data: value)
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
        
        if like {
            let task = DBTable(id: data.id, created_at: data.created_at, width: data.width, height: data.height, urls: data.urls.small, likes: data.likes, writerName: data.user.name, writerImage: data.user.profile_image.medium)
            UserInfo.shared.setLikeProduct(isLike: like, forkey: data.id)
            realmrepository.createItem(task)
        } else {
            UserInfo.shared.setLikeProduct(isLike: like, forkey: data.id)
            realmrepository.deleteItem(id: data.id)
        }
        
        outputLike.value = like
        NotificationCenter.default.post(name: NSNotification.Name("update"), object: nil, userInfo: nil)
    }
    
    func toPhotos(data: DBTable) -> Photos {
        let urlSize = UrlSize(raw: data.urls, small: data.urls)
        let profileSize = ProfileSize(medium: data.writerImage)
        let writerInfo = WriterInfo(name: data.writerName, profile_image: profileSize)
        
        return Photos(id: data.id, created_at: data.created_at, width: data.width, height: data.height, urls: urlSize, likes: data.likes, user: writerInfo)
    }

}
