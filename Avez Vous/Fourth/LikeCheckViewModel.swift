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
    
    var inputLike: Observable<DBTable?> = Observable(nil)
    var inputColor: Observable<SearchColor?> = Observable(nil)
    var inputArrayButton: Observable<Void?> = Observable(nil)
    var showLikeList: Observable<Void?> = Observable(nil)
    
    var outputResult: Observable<[DBTable]> = Observable([])
    var outputImageFiles: Observable<[UIImage]> = Observable([])
    var outputArrayButton: Observable<SearchOrder> = Observable(.latest)
    
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
