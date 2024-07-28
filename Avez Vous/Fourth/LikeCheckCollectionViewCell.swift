//
//  LikeCheckCollectionViewCell.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import UIKit
import SnapKit
import Kingfisher

final class LikeCheckCollectionViewCell: BaseCollectionViewCell {
    
    let photoImage = UIImageView()
    let likeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(photoImage)
        contentView.addSubview(likeButton)
    }
    
    override func configureLayout() {
        photoImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(photoImage.snp.trailing).inset(12)
            make.bottom.equalTo(photoImage.snp.bottom).inset(12)
            make.size.equalTo(26)
        }
    }
    
    override func configureUI() {
        photoImage.backgroundColor = .lightGray
        likeButton.setImage(CustomDesign.Images.likeActive, for: .normal)
    }
    
    func designCell(transition: UIImage) {
        photoImage.image = transition
    }

}

