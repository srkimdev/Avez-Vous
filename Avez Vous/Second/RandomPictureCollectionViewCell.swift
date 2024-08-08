//
//  RandomPictureCollectionViewCell.swift
//  Avez Vous
//
//  Created by 김성률 on 7/28/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift

final class RandomPictureCollectionViewCell: BaseCollectionViewCell {
    
    let randomImageView = UIImageView()
    let writerImage = UIImageView()
    let writerName = UILabel()
    let createLabel = UILabel()
    let likeButton = UIButton()
    let photoImage = UIImageView()
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(photoImage)
        contentView.addSubview(writerImage)
        contentView.addSubview(writerName)
        contentView.addSubview(createLabel)
        contentView.addSubview(likeButton)
    }
    
    override func configureLayout() {
        
        photoImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        writerImage.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(30)
        }
        
        writerName.snp.makeConstraints { make in
            make.top.equalTo(writerImage.snp.top).offset(2)
            make.leading.equalTo(writerImage.snp.trailing).offset(8)
            make.height.equalTo(12)
        }
        
        createLabel.snp.makeConstraints { make in
            make.bottom.equalTo(writerImage.snp.bottom).inset(2)
            make.leading.equalTo(writerImage.snp.trailing).offset(8)
            make.height.equalTo(12)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(30)
        }
        
    }

    override func configureUI() {
        
        writerImage.layer.masksToBounds = true
        writerImage.layer.cornerRadius = 15
    
        writerName.textColor = .white
        writerName.font = .systemFont(ofSize: 11)
        
        createLabel.textColor = .white
        createLabel.font = .systemFont(ofSize: 11, weight: .bold)
        
        likeButton.setImage(CustomDesign.Images.likeInactive, for: .normal)
        
    }
    
    func designCell(transition: Photos) {
        var url = URL(string: transition.urls.small)
        photoImage.kf.setImage(with: url)
        
        url = URL(string: transition.user.profile_image.medium)
        writerImage.kf.setImage(with: url, placeholder: CustomDesign.Images.placeholderImage)
        
        writerName.text = transition.user.name
        createLabel.text = "\(DateFormatterManager.shared.changeDate(transition.created_at)) 게시물"
        
        if UserInfo.shared.getLikeProduct(forkey: transition.id) {
            likeButton.setImage(CustomDesign.Images.likeActive, for: .normal)
        } else {
            likeButton.setImage(CustomDesign.Images.likeInactive, for: .normal)
        }
    }
    
}
