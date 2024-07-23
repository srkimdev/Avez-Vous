//
//  TopicTrendCollectionViewCell.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit

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
            make.width.equalTo(50)
        }
        
        starImage.snp.makeConstraints { make in
            make.leading.equalTo(likeView.snp.leading).inset(2)
            make.centerY.equalTo(likeView)
        }
        
        likeCount.snp.makeConstraints { make in
            make.trailing.equalTo(likeView.snp.trailing).inset(2)
            make.centerY.equalTo(likeView)
        }
        
    }
    
    override func configureUI() {
        photoImage.backgroundColor = .lightGray
        likeView.backgroundColor = .black
        starImage.image = UIImage(systemName: "star.fill")
        likeCount.text = "1,333"
    }
    
}
