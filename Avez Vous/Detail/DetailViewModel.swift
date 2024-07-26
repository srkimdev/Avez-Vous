//
//  DetailViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import Foundation

final class DetailViewModel {
    
    var inputDetailPhoto: Observable<Photos?> = Observable(nil)
//    var inputLikePhoto: Observable<DBTable?> = Observable(nil)
    
    var outputDetailPhoto: Observable<Photos?> = Observable(nil)
    var outputStatistics: Observable<PhotoStatistics?> = Observable(nil)
    
    init() {
        inputDetailPhoto.bind { [weak self] value in
            guard let value else { return }
            self?.outputDetailPhoto.value = value
            self?.fetchData(imageID: value.id)
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

}
