//
//  PhotoSearchViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import Foundation

final class PhotoSearchViewModel {
    
    var inputText: Observable<String?> = Observable(nil)
    var inputColor: Observable<SearchColor?> = Observable(nil)
    var inputArrayButton: Observable<Void?> = Observable(nil)
    var inputPage: Observable<Void?> = Observable(nil)
    var inputLike: Observable<Photos?> = Observable(nil)
    
    var outputArrayButton: Observable<SearchOrder> = Observable(.relevant)
    var outputResult: Observable<[Photos]> = Observable([])
    var outputScrollToTop: Observable<Void?> = Observable(nil)
    
    var arrayButtonStatus: Bool = false
    var start = 1
    var previousSearch: String = ""
    var previousColor: SearchColor?
    let realmrepository = RealmRepository()
    
    init() {
        inputText.bind { [weak self] value in
            if self?.previousSearch == value {
                print("no need to communicate")
                return
            }
            guard let value else { return }
            
            self?.previousSearch = value
            self?.fetchData(keyword: value)
        }
        
        inputArrayButton.bind { [weak self] value in
            guard let value else { return }
            
            self?.arrayButtonReversed()
        }
        
        inputColor.bind { [weak self] value in
            if self?.previousColor == value {
                print("no need to communicate")
                return
            }
            guard let value else { return }
            
            self?.previousColor = value
            self?.colorFetchData(color: value)
        }
        
        inputLike.bind { [weak self] value in
            guard let value else { return }
            self?.likeCheck(data: value)
        }
        
        inputPage.bind { [weak self] value in
            guard let value else { return }
            self?.loadMoreData()
        }
        
        realmrepository.detectRealmURL()
        
    }
    
    private func fetchData(keyword: String) {
        start = 1

        let router = RouterPattern.search(keyword: keyword, page: start, order: outputArrayButton.value, color: inputColor.value)
        
        APIManager.shared.callRequest(router: router, responseType: PhotoTotal.self) { [weak self] response in
            switch response {
            case .success(let value):
                self?.outputResult.value = value.results
                
                if value.results.count > 0 {
                    self?.outputScrollToTop.value = ()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func arrayButtonReversed() {
        start = 1
        arrayButtonStatus.toggle()
        let status = arrayButtonStatus ? SearchOrder.latest : SearchOrder.relevant
        
        outputArrayButton.value = status
        arrayFetchData(order: status)
    }
    
    private func arrayFetchData(order: SearchOrder) {
        let router = RouterPattern.search(keyword: inputText.value ?? "", page: start, order: order, color: inputColor.value)
        
        APIManager.shared.callRequest(router: router, responseType: PhotoTotal.self) { [weak self] response in
            switch response {
            case .success(let value):
                self?.outputResult.value = value.results
                
                if value.results.count > 0 {
                    self?.outputScrollToTop.value = ()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func loadMoreData() {
        start += 1
        
        let router = RouterPattern.search(keyword: inputText.value!, page: start, order: outputArrayButton.value, color: inputColor.value)
        
        APIManager.shared.callRequest(router: router, responseType: PhotoTotal.self) { [weak self] response in
            switch response {
            case .success(let value):
                self?.outputResult.value.append(contentsOf: value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func colorFetchData(color: SearchColor) {
        start = 1
        let router = RouterPattern.search(keyword: inputText.value ?? "", page: start, order: outputArrayButton.value, color: color)
        
        APIManager.shared.callRequest(router: router, responseType: PhotoTotal.self) { [weak self] response in
            switch response {
            case .success(let value):
                self?.outputResult.value = value.results
                
                if value.results.count > 0 {
                    self?.outputScrollToTop.value = ()
                }
                
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
    
}
