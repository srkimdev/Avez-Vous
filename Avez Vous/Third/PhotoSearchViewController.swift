//
//  PhotoSearchViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit

final class PhotoSearchViewController: BaseViewController {
    
    let photoSearchBar = UISearchBar()
    let redButton = UIButton()
    let purpleButton = UIButton()
    let greenButton = UIButton()
    let blueButton = UIButton()
    let arrayButton = UIButton()
    let imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    let viewModel = PhotoSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(PhotoSearchCollectionViewCell.self, forCellWithReuseIdentifier: PhotoSearchCollectionViewCell.identifier)
        photoSearchBar.delegate = self
        
        bindData()
    }
    
    override func configureHierarchy() {
        view.addSubview(photoSearchBar)
        [redButton, purpleButton, greenButton, blueButton].forEach {
            view.addSubview($0)
        }
        view.addSubview(arrayButton)
        view.addSubview(imageCollectionView)
    }
    
    override func configureLayout() {
        photoSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        redButton.snp.makeConstraints { make in
            make.top.equalTo(photoSearchBar.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.height.equalTo(28)
            make.width.equalTo(60)
        }
        
        purpleButton.snp.makeConstraints { make in
            make.top.equalTo(photoSearchBar.snp.bottom).offset(8)
            make.leading.equalTo(redButton.snp.trailing).offset(8)
            make.height.equalTo(28)
            make.width.equalTo(60)
        }
        
        greenButton.snp.makeConstraints { make in
            make.top.equalTo(photoSearchBar.snp.bottom).offset(8)
            make.leading.equalTo(purpleButton.snp.trailing).offset(8)
            make.height.equalTo(28)
            make.width.equalTo(60)
        }
        
        blueButton.snp.makeConstraints { make in
            make.top.equalTo(photoSearchBar.snp.bottom).offset(8)
            make.leading.equalTo(greenButton.snp.trailing).offset(8)
            make.height.equalTo(28)
            make.width.equalTo(60)
        }
        
        arrayButton.snp.makeConstraints { make in
            make.top.equalTo(photoSearchBar.snp.bottom).offset(8)
            make.leading.equalTo(blueButton.snp.trailing).offset(8)
            make.height.equalTo(28)
            make.width.equalTo(60)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(redButton.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureUI() {
        navigationItem.title = "SEARCH PHOTO"
        
        let buttonArray = [redButton, purpleButton, greenButton, blueButton]
        
        for item in 0...3 {
            buttonDesign(button: buttonArray[item], buttonName: " 레드")
            buttonArray[item].tag = item
        }
        
    }
    
}

extension PhotoSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        searchBar.text = nil
        
        print(text)
        
        viewModel.inputText.value = text
    }
}

extension PhotoSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputResult.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoSearchCollectionViewCell.identifier, for: indexPath) as? PhotoSearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        cell.likeButton.tag = indexPath.item
        
        cell.designCell(transition: viewModel.outputResult.value[indexPath.item])
        
        return cell
    }
    
}

extension PhotoSearchViewController: UICollectionViewDelegateFlowLayout {
    private static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 27) / 2
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
}

extension PhotoSearchViewController {
    
    private func buttonDesign(button: UIButton, buttonName: String) {
        button.setTitle(buttonName, for: .normal)
        button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 14
    }
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        print(#function)
    }
    
    private func bindData() {
        
        viewModel.outputResult.bind { [weak self] _ in
            self?.imageCollectionView.reloadData()
        }
        
    }
}
