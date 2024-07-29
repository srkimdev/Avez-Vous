//
//  CustomArrayButton.swift
//  Avez Vous
//
//  Created by 김성률 on 7/29/24.
//

import UIKit

class ArrayButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15)
        setImage(CustomDesign.Images.sort, for: .normal)
        layer.masksToBounds = true
        layer.cornerRadius = 15
        layer.borderWidth = CustomDesign.BorderWidths.Width1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
