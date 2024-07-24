//
//  TopicTrendViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import Foundation

final class TopicTrendViewModel {

    var inputAPIRequest: Observable<Void?> = Observable(nil)
    var outputTableView: Observable<[[TopicsPhoto]]> = Observable([])
    
    let randomTopic = Topic.randomCases()
    var list: [[TopicsPhoto]] = []
    
    init() {
        inputAPIRequest.bind { [weak self] value in
            guard let value else { return }
            guard let randomTopic = self?.randomTopic else { return }
            
            for item in randomTopic {
                self?.fetchData(topicID: item.rawValue) { value in
                    guard let value else { return }
                    self?.outputTableView.value.append(value)
                }
            }
        }
    }
    
    private func fetchData(topicID: String, completionHandler: @escaping ([TopicsPhoto]?) -> Void) {
        let router = RouterPattern.topic(topicID: topicID)
        APIManager.shared.callRequest(router: router, responseType: [TopicsPhoto].self) { response in
            switch response {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
