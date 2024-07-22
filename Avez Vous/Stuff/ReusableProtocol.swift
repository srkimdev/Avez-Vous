//
//  ReusableProtocol.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension UIView: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
