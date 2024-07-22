//
//  ProfileSettingViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import UIKit
import SnapKit

final class ProfileSettingViewController: BaseViewController {
    
    let profileImage = UIImageView()
    let profileImageButton = UIButton()
    let cameraImageView = UIImageView()
    let cameraImage = UIImageView()
    let nicknameTextField = UITextField()
    let textFieldLine = UIView()
    let statusLabel = UILabel()
    let clearButton = UIButton()
    let mbtiLabel = UILabel()
    
    lazy var buttonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    let viewModel = ProfileSettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonCollectionView.delegate = self
        buttonCollectionView.dataSource = self
        buttonCollectionView.register(ProfileSettingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileSettingCollectionViewCell.identifier)
    }
    
    override func configureHierarchy() {
        view.addSubview(profileImage)
        view.addSubview(profileImageButton)
        profileImageButton.addSubview(cameraImageView)
        cameraImageView.addSubview(cameraImage)
        view.addSubview(nicknameTextField)
        view.addSubview(textFieldLine)
        view.addSubview(statusLabel)
        view.addSubview(clearButton)
        view.addSubview(mbtiLabel)
        view.addSubview(buttonCollectionView)
    }
    
    override func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view.self)
            make.size.equalTo(100)
        }
        
        profileImageButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view.self)
            make.size.equalTo(100)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.trailing.equalTo(profileImageButton.snp.trailing).inset(2)
            make.bottom.equalTo(profileImageButton.snp.bottom).inset(6)
            make.size.equalTo(24)
        }
        
        cameraImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(cameraImageView.snp.width).multipliedBy(0.6)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(30)
        }
        
        textFieldLine.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(28)
            make.height.equalTo(1)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldLine.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(24)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(24)
        }
        
        buttonCollectionView.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(28)
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
        
        clearButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(40)
        }
        
        
        
        // clearButton issue
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    override func configureUI() {
        
        navigationItem.title = CustomDesign.navigationTitle.profileSetting
        BackButton()
        
        profileImage.image = UIImage(named: "profile_0")
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderWidth = CustomDesign.BorderWidths.Width3
        profileImage.layer.borderColor = CustomDesign.Colors.Blue.cgColor

        cameraImageView.backgroundColor = CustomDesign.Colors.Blue
        cameraImageView.layer.masksToBounds = true
        
        cameraImage.image = CustomDesign.Images.Camera
        cameraImage.tintColor = .white
        
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        
        textFieldLine.backgroundColor = .systemGray4
        
        statusLabel.textColor = CustomDesign.Colors.Red
        statusLabel.font = .boldSystemFont(ofSize: 13)
        
        mbtiLabel.text = "MBTI"
        mbtiLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        clearButton.setTitle(CustomDesign.Buttons.save, for: .normal)
        clearButton.setTitleColor(.white, for: .normal)
        clearButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        clearButton.backgroundColor = CustomDesign.Colors.Gray
        clearButton.layer.masksToBounds = true
        clearButton.layer.cornerRadius = 20
        
        statusLabel.text = "닉네임에 숫자는 포함할 수 없어요"
        
    }
    
    override func viewDidLayoutSubviews() {
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        cameraImageView.layer.cornerRadius = cameraImageView.frame.width / 2
    }
    
    override func configureAction() {
        
    }
    
}

extension ProfileSettingViewController {
    
    @objc func clearButtonClicked() {
        
    }
    
    @objc func profileImageButtonClicked() {
        
    }
    
    @objc func saveButtonClicked() {
        
    }
    
    private func randomImage() {
        
    }
    
    
}

extension ProfileSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = buttonCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileSettingCollectionViewCell.identifier, for: indexPath) as? ProfileSettingCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
}

extension ProfileSettingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 43, height: 43)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        return layout
    }
}
