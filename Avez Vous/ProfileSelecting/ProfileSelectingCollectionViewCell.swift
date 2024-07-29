//
//  ProfileSelectingCollectionViewCell.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit

final class ProfileSelectingCollectionViewCell: BaseCollectionViewCell {
    
    private let profileImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    override func configureHierarchy() {
        contentView.addSubview(profileImage)
    }
    
    override func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(1)
        }
    }
    
    override func configureUI() {
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderWidth = CustomDesign.BorderWidths.Width1
        profileImage.alpha = CustomDesign.Alpha.alphaHalf
    }
    
    func designCell(transition: Int, selectedImage: Int) {
        profileImage.image = UIImage(named: "profile_\(transition)")
        
        if transition == selectedImage {
            profileImage.layer.borderColor = CustomDesign.Colors.Blue.cgColor
            profileImage.layer.borderWidth = CustomDesign.BorderWidths.Width3
            profileImage.alpha = CustomDesign.Alpha.alphaOne
        } else {
            profileImage.layer.borderColor = CustomDesign.Colors.Black.cgColor
            profileImage.layer.borderWidth = CustomDesign.BorderWidths.Width1
            profileImage.alpha = CustomDesign.Alpha.alphaHalf
        }
        
    }
}
