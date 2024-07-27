//
//  UIViewController+Extension.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import UIKit



extension UIViewController {
    
    enum TransitionStyle {
        case present
        case presentNavigation
        case presentFull
        case push
    }
    
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
    
    func showAlert(title: String, message: String, completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
            
        let check = UIAlertAction(title: "확인", style: .default) { _ in
            completionHandler()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
            
        alert.addAction(cancel)
        alert.addAction(check)
            
        present(alert, animated: true)
    }
}
