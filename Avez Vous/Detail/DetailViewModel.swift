//
//  DetailViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel {
    
    let statisticsPhoto = PublishSubject<PhotoStatistics>()
    
    let realmrepository = RealmRepository()
    let disposeBag = DisposeBag()
    
    struct Input {
        let showImageInfoFromSearch: BehaviorSubject<Photos?>
        let showImageInfoFromLike: BehaviorSubject<DBTable?>
        let likeButtonTap: PublishSubject<Photos>
    }
    
    struct Output {
        let detailPhoto: BehaviorSubject<Photos?>
        let statisticsPhoto: PublishSubject<PhotoStatistics>
        let likeButtonStatus: PublishSubject<Bool>
    }
    
    func transform(input: Input) -> Output {

        let detailPhoto = BehaviorSubject<Photos?>(value: nil)
        let likeButtonStatus = PublishSubject<Bool>()
        
        input.showImageInfoFromSearch
            .compactMap { $0 }
            .bind(with: self) { owner, value in
                detailPhoto.onNext(value)
                owner.fetchData(imageID: value.id)
            }
            .disposed(by: disposeBag)
        
        input.showImageInfoFromLike
            .compactMap { $0 }
            .bind(with: self) { owner, value in
                detailPhoto.onNext(owner.toPhotos(data: value))
                owner.fetchData(imageID: value.id)
            }
            .disposed(by: disposeBag)
        
        input.likeButtonTap
            .bind(with: self) { owner, value in
                likeButtonStatus.onNext(owner.likeCheck(data: value))
            }
            .disposed(by: disposeBag)
        
        return Output(detailPhoto: detailPhoto, statisticsPhoto: statisticsPhoto, likeButtonStatus: likeButtonStatus)
    }
    
    private func fetchData(imageID: String) {
        let router = RouterPattern.statistics(imageID: imageID)
        
        APIManager.shared.callRequest(router: router, responseType: PhotoStatistics.self) { response in
            switch response {
            case .success(let value):
                self.statisticsPhoto.onNext(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func likeCheck(data: Photos) -> Bool {
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

        NotificationCenter.default.post(name: NSNotification.Name("update"), object: nil, userInfo: nil)
        
        return like
    }
    
    private func toPhotos(data: DBTable) -> Photos {
        let urlSize = UrlSize(raw: data.urls, small: data.urls)
        let profileSize = ProfileSize(medium: data.writerImage)
        let writerInfo = WriterInfo(name: data.writerName, profile_image: profileSize)
        
        return Photos(id: data.id, created_at: data.created_at, width: data.width, height: data.height, urls: urlSize, likes: data.likes, user: writerInfo)
    }

}
