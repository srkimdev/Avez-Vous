//
//  LikeCheckViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation
import RxSwift
import RxCocoa

final class LikeCheckViewModel {

    let realmrepository = RealmRepository()
    
    var arrayButtonStatus = false
    var data: [DBTable] = []
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let showList: PublishSubject<Void>
        let arrayButton: ControlEvent<Void>
        let likeButton: PublishSubject<DBTable>
    }
    
    struct Output {
        let imageInfoList: SharedSequence<DriverSharingStrategy, [DBTable]>
        let arrayButtonName: PublishSubject<SearchOrder>
    }
    
    func transform(input: Input) -> Output {
        
        let imageInfoList = PublishSubject<[DBTable]>()
        let arrayButtonName = PublishSubject<SearchOrder>()
        
        input.showList
            .bind(with: self) { owner, _ in
                
                owner.data = owner.arrayButtonStatus ? owner.realmrepository.readAllItemASC() : owner.realmrepository.readAllItemDESC()
                imageInfoList.onNext(owner.data)
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
                input.showList.onNext(())
            }
            .disposed(by: disposeBag)
        
        return Output(imageInfoList: imageInfoList.asDriver(onErrorJustReturn: []), arrayButtonName: arrayButtonName)
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
