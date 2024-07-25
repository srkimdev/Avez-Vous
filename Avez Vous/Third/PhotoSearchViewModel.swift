//
//  PhotoSearchViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import Foundation

final class PhotoSearchViewModel {
    
    var inputText: Observable<String?> = Observable(nil)
    var inputColor: Observable<SearchColor> = Observable()
    var inputArrayButton: Observable<Void?> = Observable(nil)
    var inputPage: Observable<Void?> = Observable(nil)
    var inputLike: Observable<Void?> = Observable(nil)
    
    var outputArrayButton: Observable<SearchOrder> = Observable(.relevant)
    var outputResult: Observable<[SearchPhoto]> = Observable([])
    var outputScrollToTop: Observable<Void?> = Observable(nil)
    var outputLike: Observable<Bool> = Observable(false)
    
    var arrayButtonStatus: Bool = false
    var start = 1
    
    init() {
        inputText.bind { [weak self] value in
            guard let value else { return }
            self?.fetchData(keyword: value)
        }
        
        inputArrayButton.bind { [weak self] value in
            guard let value else { return }
            self?.arrayButtonReversed()
        }
        
        inputPage.bind { [weak self] value in
            guard let value else { return }
            self?.loadMoreData()
        }
        
        inputColor.bind { [weak self] value in
            guard let value else { return }
            self?.colorFetchData(color: value)
        }
        
    }
    
    private func fetchData(keyword: String) {
        start = 1
        let router = RouterPattern.search(keyword: keyword, page: start, order: outputArrayButton.value, color: inputColor.value)
        
        APIManager.shared.callRequest(router: router, responseType: SearchPhotoTotal.self) { [weak self] response in
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
        
        APIManager.shared.callRequest(router: router, responseType: SearchPhotoTotal.self) { [weak self] response in
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
        start += 20
        
        let router = RouterPattern.search(keyword: inputText.value!, page: start, order: outputArrayButton.value, color: inputColor.value)
        
        APIManager.shared.callRequest(router: router, responseType: SearchPhotoTotal.self) { [weak self] response in
            switch response {
            case .success(let value):
                self?.outputResult.value.append(contentsOf: value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func colorFetchData(color: SearchColor) {
        let router = RouterPattern.search(keyword: inputText.value ?? "", page: start, order: outputArrayButton.value, color: color)
        
        APIManager.shared.callRequest(router: router, responseType: SearchPhotoTotal.self) { [weak self] response in
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
    
}
