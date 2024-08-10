//
//  DetailViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift

final class DetailViewController: BaseViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let profileView = UIView()
    let writerImage = UIImageView()
    let writerName = UILabel()
    let createLabel = UILabel()
    let likeButton = UIButton()
    let photoImage = UIImageView()
    
    let informationLabel = UILabel()
    let sizeLabel = UILabel()
    let sizeValue = UILabel()
    let seeLabel = UILabel()
    let seeValue = UILabel()
    let downloadLabel = UILabel()
    let downloadValue = UILabel()
    
    let viewModel = DetailViewModel()
    let disposeBag = DisposeBag()
    
    let showImageInfoFromSearch = BehaviorSubject<Photos?>(value: nil)
    let showImageInfoFromLike = BehaviorSubject<DBTable?>(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    override func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(profileView)
        contentView.addSubview(writerImage)
        contentView.addSubview(writerName)
        contentView.addSubview(createLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(photoImage)
        contentView.addSubview(informationLabel)
        contentView.addSubview(sizeLabel)
        contentView.addSubview(sizeValue)
        contentView.addSubview(seeLabel)
        contentView.addSubview(seeValue)
        contentView.addSubview(downloadLabel)
        contentView.addSubview(downloadValue)
    }
    
    override func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(58)
        }
        
        writerImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
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
            make.top.equalTo(contentView.snp.top).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).inset(16)
            make.size.equalTo(30)
        }
        
        photoImage.snp.makeConstraints { make in
            make.top.equalTo(writerImage.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImage.snp.bottom).offset(16)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.height.equalTo(24)
        }
        
        sizeLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImage.snp.bottom).offset(16)
            make.leading.equalTo(informationLabel.snp.trailing).offset(40)
            make.height.equalTo(24)
        }
        
        sizeValue.snp.makeConstraints { make in
            make.top.equalTo(photoImage.snp.bottom).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).inset(16)
            make.height.equalTo(24)
        }
        
        seeLabel.snp.makeConstraints { make in
            make.top.equalTo(sizeLabel.snp.bottom).offset(12)
            make.leading.equalTo(informationLabel.snp.trailing).offset(40)
            make.height.equalTo(24)
        }
        
        seeValue.snp.makeConstraints { make in
            make.top.equalTo(sizeValue.snp.bottom).offset(12)
            make.trailing.equalTo(contentView.snp.trailing).inset(16)
            make.height.equalTo(24)
        }
        
        downloadLabel.snp.makeConstraints { make in
            make.top.equalTo(seeLabel.snp.bottom).offset(12)
            make.leading.equalTo(informationLabel.snp.trailing).offset(40)
            make.height.equalTo(24)
        }
        
        downloadValue.snp.makeConstraints { make in
            make.top.equalTo(seeValue.snp.bottom).offset(12)
            make.trailing.equalTo(contentView.snp.trailing).inset(16)
            make.height.equalTo(24)
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureUI() {
        
        BackButton()
        
        profileView.backgroundColor = .systemGray5
        
        writerImage.layer.masksToBounds = true
        writerImage.layer.cornerRadius = 15
    
        writerName.font = .systemFont(ofSize: 11)
        
        createLabel.font = .systemFont(ofSize: 11, weight: .bold)
        
        informationLabel.text = CustomDesign.Name.information
        informationLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        
        sizeLabel.text = CustomDesign.Name.size
        sizeLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        seeLabel.text = CustomDesign.Name.seeCount
        seeLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        downloadLabel.text = CustomDesign.Name.download
        downloadLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
    }

}

extension DetailViewController {
    
    private func bindData() {

        let likeButtonTap = PublishSubject<Photos>()
        
        let input = DetailViewModel.Input(showImageInfoFromSearch: showImageInfoFromSearch, showImageInfoFromLike: showImageInfoFromLike, likeButtonTap: likeButtonTap)
        let output = viewModel.transform(input: input)
        
        output.detailPhoto
            .compactMap { $0 }
            .bind(with: self) { owner, value in
                
                var url = URL(string: value.urls.small)
                owner.photoImage.kf.setImage(with: url, placeholder: CustomDesign.Images.placeholderImage)
                owner.sizeValue.text = "\(value.width) x \(value.height)"
                owner.writerName.text = value.user.name
                owner.createLabel.text = "\(DateFormatterManager.shared.changeDate(value.created_at)) 게시물"
    
                owner.photoImage.snp.updateConstraints { make in
                    make.height.equalTo(
                        CGFloat(value.height) / CGFloat(value.width) * UIScreen.main.bounds.width
                    )
                }
                
                let image = UserInfo.shared.getLikeProduct(forkey: value.id) ? CustomDesign.Images.likeActive : CustomDesign.Images.likeInactive
                owner.likeButton.setImage(image, for: .normal)
                
                url = URL(string: value.user.profile_image.medium)
                owner.writerImage.kf.setImage(with: url, placeholder: CustomDesign.Images.placeholderImage)
            }
            .disposed(by: disposeBag)
        
        output.statisticsPhoto
            .bind(with: self) { owner, value in
                owner.seeValue.text = NumberFormatterManager.shared.Comma(value.views.total)
                owner.downloadValue.text = NumberFormatterManager.shared.Comma(value.downloads.total)
            }
            .disposed(by: disposeBag)
        
        output.likeButtonStatus
            .bind(with: self) { owner, value in
                let image = value ? CustomDesign.Images.likeActive : CustomDesign.Images.likeInactive
                owner.likeButton.setImage(image, for: .normal)
            }
            .disposed(by: disposeBag)
        
    }

}
