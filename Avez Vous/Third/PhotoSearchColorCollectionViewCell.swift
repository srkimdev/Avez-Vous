//
//  PhotoSearchColorCollectionViewCell.swift
//  Avez Vous
//
//  Created by 김성률 on 7/25/24.
//

import UIKit
import SnapKit
import Kingfisher

final class PhotoSearchColorCollectionViewCell: BaseCollectionViewCell {
    
    let backView = UIView()
    let colorImage = UIImageView()
    let colorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(colorImage)
        backView.addSubview(colorLabel)
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        colorImage.snp.makeConstraints { make in
            make.leading.equalTo(backView).offset(4)
            make.centerY.equalTo(backView.self)
            make.size.equalTo(24)
        }
        
        colorLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backView.self)
            make.leading.equalTo(colorImage.snp.trailing).offset(4)
        }
        
    }
    
    override func configureUI() {
        
        backView.layer.cornerRadius = 15
        
        colorImage.layer.masksToBounds = true
        colorImage.layer.cornerRadius = 12

        colorLabel.textAlignment = .center
        colorLabel.font = .systemFont(ofSize: 13)
    }
    
    func designCell(transition: SearchColor, selectedCell: SearchColor) {
        colorLabel.text = transition.rawValue
        colorImage.backgroundColor = transition.color
        
        if transition == selectedCell {
            backView.backgroundColor = CustomDesign.Colors.Blue
            colorLabel.textColor = .white
        } else {
            backView.backgroundColor = .systemGray5
            colorLabel.textColor = .black
        }
        
    }

}
