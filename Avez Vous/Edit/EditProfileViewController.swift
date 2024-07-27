////
////  EditProfileViewController.swift
////  Avez Vous
////
////  Created by 김성률 on 7/27/24.
////
//
//import UIKit
//import SnapKit
//
//class EditProfileViewController: BaseViewController {
//    
//    let profileImage = UIImageView()
//    let profileImageButton = UIButton()
//    let cameraImageView = UIImageView()
//    let cameraImage = UIImageView()
//    let nicknameTextField = UITextField()
//    let textFieldLine = UIView()
//    let statusLabel = UILabel()
//    let mbtiLabel = UILabel()
//    let quitLabel = UILabel()
//    
//    lazy var buttonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        buttonCollectionView.delegate = self
//        buttonCollectionView.dataSource = self
//        buttonCollectionView.register(ProfileSettingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileSettingCollectionViewCell.identifier)
//        buttonCollectionView.isScrollEnabled = false
//        
//    }
//    
//    override func configureHierarchy() {
//        view.addSubview(profileImage)
//        view.addSubview(profileImageButton)
//        profileImageButton.addSubview(cameraImageView)
//        cameraImageView.addSubview(cameraImage)
//        view.addSubview(nicknameTextField)
//        view.addSubview(textFieldLine)
//        view.addSubview(statusLabel)
//        view.addSubview(mbtiLabel)
//        view.addSubview(buttonCollectionView)
//        view.addSubview(quitLabel)
//    }
//    
//    override func configureLayout() {
//        profileImage.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.centerX.equalTo(view.self)
//            make.size.equalTo(100)
//        }
//        
//        profileImageButton.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.centerX.equalTo(view.self)
//            make.size.equalTo(100)
//        }
//        
//        cameraImageView.snp.makeConstraints { make in
//            make.trailing.equalTo(profileImageButton.snp.trailing).inset(2)
//            make.bottom.equalTo(profileImageButton.snp.bottom).inset(6)
//            make.size.equalTo(24)
//        }
//        
//        cameraImage.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.size.equalTo(cameraImageView.snp.width).multipliedBy(0.6)
//        }
//        
//        nicknameTextField.snp.makeConstraints { make in
//            make.top.equalTo(profileImageButton.snp.bottom).offset(20)
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
//            make.height.equalTo(30)
//        }
//        
//        textFieldLine.snp.makeConstraints { make in
//            make.top.equalTo(nicknameTextField.snp.bottom).offset(4)
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(28)
//            make.height.equalTo(1)
//        }
//        
//        statusLabel.snp.makeConstraints { make in
//            make.top.equalTo(textFieldLine.snp.bottom).offset(8)
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(32)
//            make.height.equalTo(24)
//        }
//        
//        mbtiLabel.snp.makeConstraints { make in
//            make.top.equalTo(statusLabel.snp.bottom).offset(20)
//            make.leading.equalTo(view.safeAreaLayoutGuide).inset(32)
//            make.height.equalTo(24)
//        }
//        
//        buttonCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(statusLabel.snp.bottom).offset(15)
//            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(28)
//            make.width.equalTo(200)
//            make.height.equalTo(100)
//        }
//        
//        quitLabel.snp.makeConstraints { make in
//            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
//            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
//            make.height.equalTo(40)
//        }
//    }
//    
//    override func configureUI() {
//        navigationItem.title = CustomDesign.navigationTitle.profileSelecting
//        let item = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
//        navigationItem.rightBarButtonItem = item
//        
//        nicknameTextField.text = UserInfo.shared.userName
//        profileImage.image = UIImage(named: "profile_\(UserInfo.shared.profileNumber)")
//        
        
//    }
//    
//    override func configureAction() {
//        profileImageButton.addTarget(self, action: #selector(profileImageButtonClicked), for: .touchUpInside)
//        nicknameTextField.addTarget(self, action: #selector(nicknameChanged), for: .editingChanged)
//    }
//    
//}
//
//extension EditProfileViewController {
//    @objc func nicknameChanged() {
//        viewModel.inputText.value = nicknameTextField.text
//    }
//    
//    
//}
//
//extension EditProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return MBTI.allCases.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = buttonCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileSettingCollectionViewCell.identifier, for: indexPath) as? ProfileSettingCollectionViewCell else { return UICollectionViewCell() }
//        
//        cell.designCell(transition: indexPath.item, selectedNumber: viewModel.outputSelectedMBTI.value ?? -1)
//
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        viewModel.inputSelectedMBTI.value = indexPath.item
//    }
//    
//}
//
//extension ProfileSettingViewController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionViewLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewFlowLayout()
//        
//        layout.itemSize = CGSize(width: 43, height: 43)
//        layout.minimumLineSpacing = 5
//        layout.minimumInteritemSpacing = 5
//        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        
//        return layout
//    }
//}
//
