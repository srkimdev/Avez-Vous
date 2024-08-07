//
//  LikeCheckViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation
import RealmSwift
import UIKit

final class LikeCheckViewModel {
    
    var inputLike: CustomObservable<DBTable?> = CustomObservable(nil)
    var inputColor: CustomObservable<SearchColor?> = CustomObservable(nil)
    var inputArrayButton: CustomObservable<Void?> = CustomObservable(nil)
    var showLikeList: CustomObservable<Void?> = CustomObservable(nil)
    
    var outputResult: CustomObservable<[DBTable]> = CustomObservable([])
    var outputImageFiles: CustomObservable<[UIImage]> = CustomObservable([])
    var outputArrayButton: CustomObservable<SearchOrder> = CustomObservable(.latest)
    
    let realmrepository = RealmRepository()
    var realmToDummy: DBTable?
    
    var arrayButtonStatus = false
    
    init() {
        showLikeList.bind { _ in
            
            var data: [DBTable] = []
            if self.arrayButtonStatus {
                data = self.realmrepository.readAllItemASC()
            } else {
                data = self.realmrepository.readAllItemDESC()
            }
        
            self.outputResult.value = data
            
            var uiImageData: [UIImage] = []
            for item in data {
                uiImageData.append(FilesManager.shared.loadImageToDocument(filename: item.id)!)
            }
            
            self.outputImageFiles.value = uiImageData
        }
        
        inputLike.bind { [weak self] value in
            guard let value else { return }
            self?.likeCheck(data: value)
        }
        
        inputArrayButton.bind { [weak self] value in
            guard let value else { return }
            self?.arrayButtonReversed()
        }
        
    }
    
    private func likeCheck(data: DBTable) {
        UserInfo.shared.setLikeProduct(isLike: false, forkey: data.id)
        FilesManager.shared.removeImageFromDocument(filename: data.id)
        realmrepository.deleteItem(id: data.id)
        
        showLikeList.value = ()
        NotificationCenter.default.post(name: NSNotification.Name("update"), object: nil, userInfo: nil)
    }
    
    private func arrayButtonReversed() {
        arrayButtonStatus.toggle()
        let status = arrayButtonStatus ? SearchOrder.past : SearchOrder.latest
        
        outputArrayButton.value = status
        showLikeList.value = ()
    }
}
