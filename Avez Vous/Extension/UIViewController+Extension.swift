//
//  UIViewController+Extension.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import UIKit



extension UIViewController {
    
    func BackButton() {
        let item = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        item.tintColor = CustomDesign.Colors.Black
        navigationItem.leftBarButtonItem = item
    }
    
    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func transitionScreen<T: UIViewController>(vc: T, style: TransitionStyle) {
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFull:
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
