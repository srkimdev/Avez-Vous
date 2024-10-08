//
//  ProfileSettingViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import UIKit
import SnapKit
import RxSwift

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
    let quitButton = UIButton()
    
    lazy var buttonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    let viewModel = ProfileSettingViewModel()
    let disposeBag = DisposeBag()
    
    var selectedClosure: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonCollectionView.register(ProfileSettingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileSettingCollectionViewCell.identifier)
        buttonCollectionView.isScrollEnabled = false
        
        bindData()
    }
    
    override func viewDidLayoutSubviews() {
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
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
        view.addSubview(quitButton)
    }
    
    override func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        
        profileImageButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
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
        
        quitButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(100)
        }
        
    }
    
    override func configureUI() {
        if UserDefaultsManager.shared.mode == Mode.edit.rawValue {
            navigationItem.title = CustomDesign.NavigationTitle.profileSelecting
            let item = UIBarButtonItem(title: CustomDesign.Buttons.save, style: .plain, target: self, action: #selector(saveButtonClicked))
            navigationItem.rightBarButtonItem = item
            
            nicknameTextField.text = UserInfo.shared.userName
            clearButton.isHidden = true
            quitButton.isHidden = false
            
//            viewModel.outputImageNumber.value = UserInfo.shared.profileNumber
//            viewModel.inputText.value = UserInfo.shared.userName
//            
//            // show current MBTI Trigger
//            viewModel.inputMBTISetting.value = ()
            
        } else {
            navigationItem.title = CustomDesign.NavigationTitle.profileSetting
            
            clearButton.isHidden = false
            quitButton.isHidden = true
            
//            viewModel.showRandomImage.value = ()
        }

        BackButton()
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderWidth = CustomDesign.BorderWidths.Width3
        profileImage.layer.borderColor = CustomDesign.Colors.Blue.cgColor

        cameraImageView.backgroundColor = CustomDesign.Colors.Blue
        cameraImageView.layer.masksToBounds = true
        cameraImageView.layer.cornerRadius = 12
        
        cameraImage.image = CustomDesign.Images.camera
        cameraImage.tintColor = .white
        
        nicknameTextField.placeholder = CustomDesign.Placeholder.nickname
        
        textFieldLine.backgroundColor = .systemGray4
    
        statusLabel.font = .boldSystemFont(ofSize: 13)
        
        mbtiLabel.text = CustomDesign.Name.mbti
        mbtiLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        clearButton.setTitle(CustomDesign.Buttons.clear, for: .normal)
        clearButton.setTitleColor(.white, for: .normal)
        clearButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        clearButton.layer.masksToBounds = true
        clearButton.layer.cornerRadius = 20
        
        quitButton.setTitle(CustomDesign.Buttons.quit, for: .normal)
        quitButton.titleLabel?.font = .systemFont(ofSize: 18)
        quitButton.setTitleColor(CustomDesign.Colors.Blue, for: .normal)
        
    }
    
    override func configureAction() {
        quitButton.addTarget(self, action: #selector(quitButtonClicked), for: .touchUpInside)
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

extension ProfileSettingViewController {
    
    @objc func saveButtonClicked() {
        
//        if viewModel.outputAllow.value {
//            // save userInfo
//            UserInfo.shared.userName = viewModel.inputText.value!
//            UserInfo.shared.profileNumber = viewModel.outputImageNumber.value
//            UserInfo.shared.MBTI = viewModel.mbtiArray
//            selectedClosure?(UserInfo.shared.profileNumber)
//            
//            navigationController?.popViewController(animated: true)
//        } else {
//            showAlertForNickname(title: CustomDesign.AlertMessage.nick)
//        }
        
    }
    
    @objc func quitButtonClicked() {
        showAlert(title: "탈퇴하기", message: CustomDesign.AlertMessage.quit, completionHandler: initialize)
    }
    
    private func bindData() {
        
        let randomImageTrigger = Observable<Void>.just(())
        let showCurrentMBTI = Observable<Void>.just(())
        
        let input = ProfileSettingViewModel.Input(randomImageTrigger: randomImageTrigger, nickName: nicknameTextField.rx.text.orEmpty, showCurrentMBTI: showCurrentMBTI, clearButtonTap: clearButton.rx.tap, profileImageTap: profileImageButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.showRandomImage
            .map { UIImage(named: "profile_\($0)") }
            .bind(to: profileImage.rx.image)
            .disposed(by: disposeBag)
        
        output.nickNameStatus
            .bind(with: self) { owner, value in
                owner.statusLabel.text = value
            }
            .disposed(by: disposeBag)
        
        output.nickNameAllow
            .bind(with: self) { owner, value in
                owner.statusLabel.textColor = value ? CustomDesign.Colors.Blue : CustomDesign.Colors.Red
            }
            .disposed(by: disposeBag)
        
        output.clearButtonTap
            .bind(with: self) { owner, value in
                if value {
                    let vc = TabBarViewController()
                    
                    // save userInfo
                    UserInfo.shared.userName = owner.nicknameTextField.text!
                    UserInfo.shared.MBTI = owner.viewModel.mbtiArray
                    UserInfo.shared.profileNumber = owner.viewModel.profileImage
                    UserDefaultsManager.shared.mode = Mode.edit.rawValue
                    
                    owner.transitionScreen(vc: vc, style: .presentFull)
                }
            }
            .disposed(by: disposeBag)
        
        output.profileImageTap
            .bind(with: self) { owner, value in
                let vc = ProfileSelectingViewController()
                
                vc.viewModel.profileImage
                    .accept(value)
                
                vc.selectedClosure = { value in
                    owner.viewModel.profileImage = value
                    self.profileImage.image = UIImage(named: "profile_\(value)")
                }
                
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.mbtiAllow, viewModel.nicknameAllow)
            .map { $0.0 && $0.1 }
            .bind(with: self) { owner, value in
                owner.clearButton.backgroundColor = value ? CustomDesign.Colors.Blue : CustomDesign.Colors.Gray
            }
            .disposed(by: disposeBag)
            
        Observable.just([0, 1, 2, 3, 4, 5, 6, 7])
            .bind(to: buttonCollectionView.rx.items(cellIdentifier: ProfileSettingCollectionViewCell.identifier, cellType: ProfileSettingCollectionViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: item, mbtiArray: self.viewModel.mbtiArray)
                
            }
            .disposed(by: disposeBag)
        
        
        buttonCollectionView.rx.itemSelected
            .map { indexPath in indexPath.row }
            .bind(with: self) { owner, value in
            
                owner.viewModel.mbtiSave(value: value)
                owner.buttonCollectionView.reloadData()

            }
            .disposed(by: disposeBag)
        
        
    }
    
    private func initialize() {
        
        // reset all userDefaults
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let rootViewcontroller = UINavigationController(rootViewController: OnBoardingViewController())
        
        sceneDelegate?.window?.rootViewController = rootViewcontroller
        sceneDelegate?.window?.makeKeyAndVisible()
        
    }
    
}

