//
//  PhotoSearchViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import Foundation

final class PhotoSearchViewModel {
    
    var inputText: Observable<String?> = Observable(nil)
    var inputColor: Observable<String?> = Observable(nil)
    var inputArray: Observable<String?> = Observable(nil)
    
    var outputResult: Observable<[SearchPhoto]> = Observable([])
    
    
    init() {
        inputText.bind { [weak self] value in
            guard let value else { return }
            
            self?.fetchData(keyword: value) { result in
                guard let result else { return }
                self?.outputResult.value = result
            }
        }
        
    }
    
    private func fetchData(keyword: String, completionHandler: @escaping ([SearchPhoto]?) -> Void) {
        let router = RouterPattern.search(keyword: keyword, order: "latest", color: "black")
        
        APIManager.shared.callRequest(router: router, responseType: SearchPhotoTotal.self) { response in
            switch response {
            case .success(let value):
                print(value)
                completionHandler(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
