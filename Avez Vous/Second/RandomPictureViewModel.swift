//
//  RandomPictureViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/28/24.
//

import Foundation
import RxSwift
import RxCocoa

final class RandomPictureViewModel {

    let realmrepository = RealmRepository()
    
    private func fetchData(transition: PublishSubject<[Photos]>) {
        let router = RouterPattern.random
        
        APIManager.shared.callRequest(router: router, responseType: [Photos].self) { response in
            switch response {
            case .success(let value):
                transition.onNext(value)
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

    }
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let callRequest: PublishSubject<Void>
        let pullToRefresh: PublishSubject<Void>
        let likeButtonTap: PublishSubject<Photos>
    }
    
    struct Output {
        let imageList: SharedSequence<DriverSharingStrategy, [Photos]>
        let reloadData: PublishSubject<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let imageList = PublishSubject<[Photos]>()
        let reloadData = PublishSubject<Void>()
        
        input.callRequest
            .bind(with: self) { owner, _ in
                owner.fetchData(transition: imageList)
            }
            .disposed(by: disposeBag)
        
        input.pullToRefresh
            .bind(with: self) { owner, _ in
                owner.fetchData(transition: imageList)
            }
            .disposed(by: disposeBag)
        
        input.likeButtonTap
            .bind(with: self) { owner, value in
                owner.likeCheck(data: value)
                reloadData.onNext(())
            }
            .disposed(by: disposeBag)
        
        return Output(imageList: imageList.asDriver(onErrorJustReturn: []), reloadData: reloadData)
    }
    
}
