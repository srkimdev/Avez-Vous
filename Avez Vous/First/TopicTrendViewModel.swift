//
//  TopicTrendViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.


import Foundation
import RxSwift
import RxCocoa

final class TopicTrendViewModel {
    
    let disposeBag = DisposeBag()
    private var outputTableView: [[Photos]] = []
    var randomTopics: [Topic]?
    
    struct Input {
        let callRequest: PublishSubject<Void>
        let pullToRefresh: PublishSubject<Void>
    }
    
    struct Output {
        let tableViewList: SharedSequence<DriverSharingStrategy, [[Photos]]>
    }
    
    func transform(input: Input) -> Output {
        
        let outputTemp = PublishSubject<[[Photos]]>()
       
        input.callRequest
            .bind(with: self) { owner, _ in
                owner.createRandomTopic(transition: outputTemp)
                print("here")
            }
            .disposed(by: disposeBag)
        
        input.pullToRefresh
            .bind(with: self) { owner, _ in
                owner.createRandomTopic(transition: outputTemp)
            }
            .disposed(by: disposeBag)
        
        return Output(tableViewList: outputTemp.asDriver(onErrorJustReturn: []))
        
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
    
    private func createRandomTopic(transition: PublishSubject<[[Photos]]>) {
    
        outputTableView = []
        let randomTopic = Topic.randomCases()
        
        for item in randomTopic {
            fetchData(topicID: item.rawValue) { value in
                guard let value else { return }
                self.outputTableView.append(value)
                transition.onNext(self.outputTableView)
            }
        }
        randomTopics = randomTopic
    }
    
}
