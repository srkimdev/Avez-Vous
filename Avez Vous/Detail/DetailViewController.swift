//
//  DetailViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailViewController: BaseViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindData()
    }
    
    override func configureHierarchy() {
        view.addSubview(profileView)
        view.addSubview(writerImage)
        view.addSubview(writerName)
        view.addSubview(createLabel)
        view.addSubview(likeButton)
        view.addSubview(photoImage)
        view.addSubview(informationLabel)
        view.addSubview(sizeLabel)
        view.addSubview(sizeValue)
        view.addSubview(seeLabel)
        view.addSubview(seeValue)
        view.addSubview(downloadLabel)
        view.addSubview(downloadValue)
    }
    
    override func configureLayout() {
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(58)
        }
        
        writerImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.size.equalTo(30)
        }
        
        photoImage.snp.makeConstraints { make in
            make.top.equalTo(writerImage.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(180)
        }
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImage.snp.bottom).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(24)
        }
        
        sizeLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImage.snp.bottom).offset(16)
            make.leading.equalTo(informationLabel.snp.trailing).offset(40)
            make.height.equalTo(24)
        }
        
        sizeValue.snp.makeConstraints { make in
            make.top.equalTo(photoImage.snp.bottom).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        seeLabel.snp.makeConstraints { make in
            make.top.equalTo(sizeLabel.snp.bottom).offset(12)
            make.leading.equalTo(informationLabel.snp.trailing).offset(40)
            make.height.equalTo(24)
        }
        
        seeValue.snp.makeConstraints { make in
            make.top.equalTo(sizeValue.snp.bottom).offset(12)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        downloadLabel.snp.makeConstraints { make in
            make.top.equalTo(seeLabel.snp.bottom).offset(12)
            make.leading.equalTo(informationLabel.snp.trailing).offset(40)
            make.height.equalTo(24)
        }
        
        downloadValue.snp.makeConstraints { make in
            make.top.equalTo(seeValue.snp.bottom).offset(12)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
    }
    
    override func configureUI() {
        
        BackButton()
        
        profileView.backgroundColor = .systemGray5
        
        writerImage.backgroundColor = .lightGray
        writerImage.layer.masksToBounds = true
        writerImage.layer.cornerRadius = 15
    
        writerName.font = .systemFont(ofSize: 11)
        
        let image = UserInfo.shared.getLikeProduct(forkey: viewModel.outputDetailPhoto.value!.id) ? CustomDesign.Images.likeActive : CustomDesign.Images.likeInactive
        likeButton.setImage(image, for: .normal)
        
        createLabel.font = .systemFont(ofSize: 11, weight: .bold)
        
        informationLabel.text = "정보"
        informationLabel.font = .systemFont(ofSize: 18, weight: .heavy)
        
        sizeLabel.text = "크기"
        sizeLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        seeLabel.text = "조회수"
        seeLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        downloadLabel.text = "다운로드"
        downloadLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
    }
    
    override func configureAction() {
        likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
    }
    
}

extension DetailViewController {
    
    private func bindData() {
        
        viewModel.outputDetailPhoto.bind { [weak self] value in
            guard let value else { return }
    
            var url = URL(string: value.urls.small)
            self?.photoImage.kf.setImage(with: url, placeholder: CustomDesign.Images.placeholderImage)
            self?.sizeValue.text = "\(value.width) x \(value.height)"
            self?.writerName.text = value.user.name
            self?.createLabel.text = "\(DateFormatterManager.shared.changeDate(value.created_at)) 게시물"
            
            url = URL(string: value.user.profile_image.medium)
            self?.writerImage.kf.setImage(with: url, placeholder: CustomDesign.Images.placeholderImage)
        }
        
        viewModel.outputStatistics.bind { [weak self] value in
            guard let value else { return }
            
            self?.seeValue.text = NumberFormatterManager.shared.Comma(value.views.total)
            self?.downloadValue.text = NumberFormatterManager.shared.Comma(value.downloads.total)
        }
        
        viewModel.outputLike.bind { [weak self] value in
            guard let value else { return }
            
            let image = value ? CustomDesign.Images.likeActive : CustomDesign.Images.likeInactive
            self?.likeButton.setImage(image, for: .normal)
        }
        
    }
    
    @objc func likeButtonClicked() {
        viewModel.inputLike.value = viewModel.inputFromSearch.value
    }
}
