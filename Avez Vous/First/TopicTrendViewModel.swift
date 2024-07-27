//
//  TopicTrendViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import Foundation

final class TopicTrendViewModel {

    var inputAPIRequest: Observable<Void?> = Observable(nil)
    var outputTableView: Observable<[[Photos]]> = Observable([])
    
    var list: [[Photos]] = []
    var randomTopics: [Topic]?
    
    init() {
        inputAPIRequest.bind { [weak self] value in
            guard let value else { return }
            self?.outputTableView.value = []
            
            let randomTopic = Topic.randomCases()
            
            for item in randomTopic {
                self?.fetchData(topicID: item.rawValue) { value in
                    guard let value else { return }
                    self?.outputTableView.value.append(value)
                }
            }
            
            self?.randomTopics = randomTopic
        }
    }
    
    private func fetchData(topicID: String, completionHandler: @escaping ([Photos]?) -> Void) {
        let router = RouterPattern.topic(topicID: topicID)
        
        APIManager.shared.callRequest(router: router, responseType: [Photos].self) { response in
            switch response {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
