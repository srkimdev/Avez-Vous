//
//  ProfileSelectingViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit

final class ProfileSelectingViewController: BaseViewController {
    
    let selectedImage = UIImageView()
    let selectedImageView = UIImageView()
    let cameraImageView = UIImageView()
    let cameraImage = UIImageView()
    
    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var selectedClosure: ((Int) -> Void)?
    let viewModel = ProfileSelectingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(ProfileSelectingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileSelectingCollectionViewCell.identifier)
        
        bindData()
    }
    
    override func viewDidLayoutSubviews() {
        selectedImage.layer.cornerRadius = selectedImage.frame.width / 2
        cameraImageView.layer.cornerRadius = cameraImageView.frame.width / 2
    }
    
    override func configureHierarchy() {
        view.addSubview(selectedImage)
        view.addSubview(selectedImageView)
        selectedImageView.addSubview(cameraImageView)
        cameraImageView.addSubview(cameraImage)
        view.addSubview(imageCollectionView)
    }
    
    override func configureLayout() {
        selectedImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view.self)
            make.size.equalTo(100)
        }
        
        selectedImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view.self)
            make.size.equalTo(100)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.trailing.equalTo(selectedImageView.snp.trailing).inset(2)
            make.bottom.equalTo(selectedImageView.snp.bottom).inset(6)
            make.size.equalTo(24)
        }
        
        cameraImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(cameraImageView.snp.width).multipliedBy(0.6)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(selectedImageView.snp.bottom).offset(60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(300)
        }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    override func configureUI() {
        navigationItem.title = CustomDesign.navigationTitle.profileSelecting
        BackButton()
        
        selectedImage.layer.masksToBounds = true
        selectedImage.layer.borderWidth = CustomDesign.BorderWidths.Width3
        selectedImage.layer.borderColor = CustomDesign.Colors.Blue.cgColor

        cameraImageView.backgroundColor = CustomDesign.Colors.Blue
        cameraImageView.layer.masksToBounds = true
        
        cameraImage.image = CustomDesign.Images.camera
        cameraImage.tintColor = .white
    }
    
}

extension ProfileSelectingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileImages.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileSelectingCollectionViewCell.identifier, for: indexPath) as? ProfileSelectingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.designCell(transition: indexPath.item, selectedImage: viewModel.outputSelectedImage.value)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputSelectedImage.value = indexPath.item
        selectedClosure?(indexPath.item)
    }
    
}

extension ProfileSelectingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 70
        
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
    }
}

extension ProfileSelectingViewController {
    
    private func bindData() {
        viewModel.outputSelectedImage.bind { [weak self] value in
            self?.selectedImage.image = UIImage(named: "profile_\(value)")
            self?.imageCollectionView.reloadData()
        }
    }
    
}
