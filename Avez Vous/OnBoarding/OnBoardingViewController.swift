//
//  OnBoardingViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import UIKit

class OnBoardingViewController: BaseViewController {

    let mainView = OnBoardingView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func configureAction() {
        mainView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        transitionScreen(vc: ProfileSettingViewController(), style: .push)
    }
    
}
