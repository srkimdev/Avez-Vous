//
//  ProfileSettingCollectionViewCell.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import UIKit
import SnapKit

final class ProfileSettingCollectionViewCell: BaseCollectionViewCell {
    
    let backgroundScene = UIView()
    let mbtiLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundScene.layer.cornerRadius = backgroundScene.frame.width / 2
    }
    
    override func configureHierarchy() {
        contentView.addSubview(backgroundScene)
        backgroundScene.addSubview(mbtiLabel)
    }
    
    override func configureLayout() {
        backgroundScene.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.center.equalTo(backgroundScene)
        }
    }
    
    override func configureUI() {
        backgroundScene.layer.borderWidth = CustomDesign.BorderWidths.Width1
        backgroundScene.layer.borderColor = CustomDesign.Colors.Gray.cgColor
        
        mbtiLabel.textColor = CustomDesign.Colors.Gray
    }
    
    func designCell(transition: Int, mbtiArray: [Int]) {
        
        if mbtiArray.contains(transition) {
            activeButton()
        } else {
            deactiveButton()
        }
        
        mbtiLabel.text = MBTI.allCases[transition].rawValue
    }
    
    private func activeButton() {
        backgroundScene.backgroundColor = CustomDesign.Colors.Blue
        mbtiLabel.textColor = CustomDesign.Colors.White
    }
    
    private func deactiveButton() {
        backgroundScene.backgroundColor = CustomDesign.Colors.White
        mbtiLabel.textColor = CustomDesign.Colors.Gray
    }
    
}

