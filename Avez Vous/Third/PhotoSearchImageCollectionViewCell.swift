//
//  PhotoSearchCollectionViewCell.swift
//  Avez Vous
//
//  Created by 김성률 on 7/24/24.
//

import UIKit
import SnapKit
import Kingfisher

final class PhotoSearchImageCollectionViewCell: BaseCollectionViewCell {
    
    let photoImage = UIImageView()
    let likeButtonView = UIView()
    let likeImage = UIImageView()
    let likeButton = UIButton()
    
    let likeView = UIImageView()
    let starImage = UIImageView()
    let likeCount = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(photoImage)
        contentView.addSubview(likeButtonView)
        likeButtonView.addSubview(likeImage)
        likeButtonView.addSubview(likeButton)
        photoImage.addSubview(likeView)
        likeView.addSubview(starImage)
        likeView.addSubview(likeCount)
    }
    
    override func configureLayout() {
        photoImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        likeButtonView.snp.makeConstraints { make in
            make.trailing.equalTo(photoImage.snp.trailing).inset(12)
            make.bottom.equalTo(photoImage.snp.bottom).inset(12)
            make.size.equalTo(26)
        }
        
        likeImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(likeButtonView.snp.width).multipliedBy(0.7)
        }
        
        likeButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        likeView.snp.makeConstraints { make in
            make.leading.equalTo(photoImage.snp.leading).inset(12)
            make.bottom.equalTo(photoImage.snp.bottom).inset(12)
            make.height.equalTo(20)
            make.width.equalTo(55)
        }
        
        starImage.snp.makeConstraints { make in
            make.leading.equalTo(likeView.snp.leading).inset(5)
            make.centerY.equalTo(likeView)
            make.size.equalTo(10)
        }
        
        likeCount.snp.makeConstraints { make in
            make.trailing.equalTo(likeView.snp.trailing).inset(10)
            make.centerY.equalTo(likeView)
        }
    }
    
    override func configureUI() {
        photoImage.backgroundColor = .lightGray
        
        likeButtonView.backgroundColor = .white
        likeButtonView.layer.masksToBounds = true
        likeButtonView.layer.cornerRadius = 13
        
        likeImage.image = UIImage(named: "like")
        
        likeView.backgroundColor = .darkGray
        likeView.layer.masksToBounds = true
        likeView.layer.cornerRadius = 10
        
        starImage.image = CustomDesign.Images.star
        starImage.tintColor = CustomDesign.Colors.star
        
        likeCount.textColor = .white
        likeCount.font = .systemFont(ofSize: 10)
    }
    
    func designCell(transition: SearchPhoto) {
        let url = URL(string: transition.urls.small)
        photoImage.kf.setImage(with: url, placeholder: CustomDesign.Images.placeholderImage)
        
        likeCount.text = NumberFormatterManager.shared.Comma(transition.likes)
    }

}
