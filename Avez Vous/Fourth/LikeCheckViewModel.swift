//
//  LikeCheckViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class LikeCheckViewModel {

    let realmrepository = RealmRepository()
    
    var arrayButtonStatus = false
    var data: [DBTable] = []
    var uiImageData: [UIImage] = []
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let showList: PublishSubject<Void>
        let arrayButton: ControlEvent<Void>
        let likeButton: PublishSubject<DBTable>
    }
    
    struct Output {
        let imageInfoList: SharedSequence<DriverSharingStrategy, [DBTable]>
        let imageList: PublishSubject<[UIImage]>
        let arrayButtonName: PublishSubject<SearchOrder>
        let reloadData: PublishSubject<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let imageInfoList = PublishSubject<[DBTable]>()
        let imageList = PublishSubject<[UIImage]>()
        let arrayButtonName = PublishSubject<SearchOrder>()
        let reloadData = PublishSubject<Void>()
        
        input.showList
            .bind(with: self) { owner, _ in
                
                owner.data = owner.arrayButtonStatus ? owner.realmrepository.readAllItemASC() : owner.realmrepository.readAllItemDESC()
                
                imageInfoList.onNext(owner.data)
                
                // FileManager
                owner.uiImageData = []
                for item in owner.data {
                    owner.uiImageData.append(FilesManager.shared.loadImageToDocument(filename: item.id)!)
                }
    
                imageList.onNext(owner.uiImageData)
                
            }
            .disposed(by: disposeBag)
        
        input.arrayButton
            .bind(with: self) { owner, _ in
                arrayButtonName.onNext(owner.arrayButtonReversed())
                input.showList.onNext(())
            }
            .disposed(by: disposeBag)
        
        input.likeButton
            .bind(with: self) { owner, value in
                owner.likeCheck(data: value)
                reloadData.onNext(())
            }
            .disposed(by: disposeBag)
        
        return Output(imageInfoList: imageInfoList.asDriver(onErrorJustReturn: []), imageList: imageList, arrayButtonName: arrayButtonName, reloadData: reloadData)
    }
    
    
    private func likeCheck(data: DBTable) {
        UserInfo.shared.setLikeProduct(isLike: false, forkey: data.id)
        FilesManager.shared.removeImageFromDocument(filename: data.id)
        realmrepository.deleteItem(id: data.id)

        NotificationCenter.default.post(name: NSNotification.Name("update"), object: nil, userInfo: nil)
    }
    
    private func arrayButtonReversed() -> SearchOrder {
        arrayButtonStatus.toggle()
        let status = arrayButtonStatus ? SearchOrder.past : SearchOrder.latest
        
        return status
    }
}
