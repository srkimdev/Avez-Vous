//
//  TopicTrendCollectionViewCell.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit
import Kingfisher

final class TopicTrendCollectionViewCell: BaseCollectionViewCell {
    
    let photoImage = UIImageView()
    let likeView = UIImageView()
    let starImage = UIImageView()
    let likeCount = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(photoImage)
        photoImage.addSubview(likeView)
        likeView.addSubview(starImage)
        likeView.addSubview(likeCount)
    }
    
    override func configureLayout() {
        photoImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        likeView.snp.makeConstraints { make in
            make.leading.equalTo(photoImage.snp.leading).inset(8)
            make.bottom.equalTo(photoImage.snp.bottom).inset(8)
            make.height.equalTo(20)
            make.width.equalTo(55)
        }
        
        starImage.snp.makeConstraints { make in
            make.leading.equalTo(likeView.snp.leading).inset(5)
            make.centerY.equalTo(likeView)
            make.size.equalTo(10)
        }
        
        likeCount.snp.makeConstraints { make in
            make.leading.equalTo(starImage.snp.trailing).offset(5)
            make.trailing.equalTo(likeView.snp.trailing).inset(5)
            make.centerY.equalTo(likeView)
        }
        
    }
    
    override func configureUI() {
        photoImage.backgroundColor = .lightGray
        photoImage.layer.masksToBounds = true
        photoImage.layer.cornerRadius = 10
        
        likeView.backgroundColor = .darkGray
        likeView.layer.masksToBounds = true
        likeView.layer.cornerRadius = 10
        
        starImage.image = UIImage(systemName: "star.fill")
        starImage.tintColor = CustomDesign.Colors.star

        likeCount.textColor = .white
        likeCount.textAlignment = .center
        likeCount.font = .systemFont(ofSize: 10)
    }
    
    func designCell(transition: TopicsPhoto) {
        let placeholderImage = UIImage(named: "placeholderImage")
        let url = URL(string: transition.urls.small)
        photoImage.kf.setImage(with: url, placeholder: placeholderImage)
        
        likeCount.text = NumberFormatterManager.shared.Comma(transition.likes)
    }
    
}
