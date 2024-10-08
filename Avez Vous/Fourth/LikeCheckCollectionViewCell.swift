//
//  LikeCheckCollectionViewCell.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift

final class LikeCheckCollectionViewCell: BaseCollectionViewCell {
    
    let photoImage = UIImageView()
    let likeButton = UIButton()
    
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
    
    func designCell(transition: DBTable) {
        photoImage.image = FilesManager.shared.loadImageToDocument(filename: transition.id)
    }

}

