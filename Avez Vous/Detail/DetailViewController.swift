//
//  DetailViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/26/24.
//

import UIKit
import SnapKit

final class DetailViewController: BaseViewController {
    
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
        
        writerImage.backgroundColor = .lightGray
        writerImage.layer.masksToBounds = true
        writerImage.layer.cornerRadius = 15
        
        writerName.text = "Brayden Prato"
        writerName.font = .systemFont(ofSize: 11)
        
        createLabel.text = "2024년 7월 3일 게시물"
        createLabel.font = .systemFont(ofSize: 11, weight: .bold)
        
        likeButton.setImage(UIImage(named: "like"), for: .normal)
        
        photoImage.backgroundColor = .lightGray
        
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
        
    }
    
    private func bindData() {
        
        viewModel.outputDetailPhoto.bind { [weak self] value in
            guard let value else { return }
            
            self?.sizeLabel.text = "\(value.width) x \(value.height)"
        }
        
        viewModel.outputStatistics.bind { [weak self] value in
            guard let value else { return }
            
            self?.seeValue.text = "\(value.views.total)"
            self?.downloadValue.text = "\(value.downloads.total)"
        }
        
    }
}
