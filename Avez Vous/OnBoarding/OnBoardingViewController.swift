//
//  OnBoardingViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import UIKit
import RxSwift
import RxCocoa

final class OnBoardingViewController: BaseViewController {

    private let mainView = OnBoardingView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultsManager.shared.mode = Mode.setup.rawValue
        bind()
    }
    
    func bind() {
        mainView.startButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.transitionScreen(vc: ProfileSettingViewController(), style: .push)
            }
            .disposed(by: disposeBag)
    }
    
}
