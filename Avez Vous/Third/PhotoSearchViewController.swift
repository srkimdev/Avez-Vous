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
    let arrayButton = UIButton()
    let searchStatusLabel = UILabel()
    
    lazy var colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: colorCollectionViewLayout())
    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: imageCollectionViewLayout())
    
    let viewModel = PhotoSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.prefetchDataSource = self
        imageCollectionView.register(PhotoSearchImageCollectionViewCell.self, forCellWithReuseIdentifier: PhotoSearchImageCollectionViewCell.identifier)
        
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        colorCollectionView.register(PhotoSearchColorCollectionViewCell.self, forCellWithReuseIdentifier: PhotoSearchColorCollectionViewCell.identifier)
        
        photoSearchBar.delegate = self
        
        bindData()
    }
    
    override func configureHierarchy() {
        view.addSubview(photoSearchBar)
        view.addSubview(colorCollectionView)
        view.addSubview(arrayButton)
        view.addSubview(searchStatusLabel)
        view.addSubview(imageCollectionView)
    }
    
    override func configureLayout() {
        photoSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        
        arrayButton.snp.makeConstraints { make in
            make.top.equalTo(photoSearchBar.snp.bottom).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(30)
            make.width.equalTo(70)
        }
        
        colorCollectionView.snp.makeConstraints { make in
            make.top.equalTo(photoSearchBar.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(arrayButton.snp.leading).offset(-10)
            make.height.equalTo(30)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(colorCollectionView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchStatusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageCollectionView)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureUI() {
        navigationItem.title = "SEARCH PHOTO"
        photoSearchBar.searchBarStyle = .minimal
        
        arrayButton.setTitle("관련순", for: .normal)
        arrayButton.setTitleColor(.black, for: .normal)
        arrayButton.titleLabel?.font = .systemFont(ofSize: 15)
        arrayButton.setImage(UIImage(named: "sort"), for: .normal)
        arrayButton.layer.masksToBounds = true
        arrayButton.layer.cornerRadius = 15
        arrayButton.layer.borderWidth = 1
        arrayButton.layer.borderColor = UIColor.lightGray.cgColor
        
        searchStatusLabel.text = "사진을 검색해보세요."
        searchStatusLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        imageCollectionView.isHidden = true
    }
    
    override func configureAction() {
        arrayButton.addTarget(self, action: #selector(arrayButtonClicked), for: .touchUpInside)
    }
    
}

extension PhotoSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.contains(" ") else {
            searchStatusLabel.text = "사진을 검색해보세요."
            imageCollectionView.isHidden = true
            return
        }
        viewModel.inputText.value = text
    }
}

extension PhotoSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView {
            return viewModel.outputResult.value.count
        } else {
            return SearchColor.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView {
            guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoSearchImageCollectionViewCell.identifier, for: indexPath) as? PhotoSearchImageCollectionViewCell else { return UICollectionViewCell() }
            
            cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
            cell.likeButton.tag = indexPath.item
            cell.designCell(transition: viewModel.outputResult.value[indexPath.item])
            
            return cell
        } else {
            guard let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoSearchColorCollectionViewCell.identifier, for: indexPath) as? PhotoSearchColorCollectionViewCell else { return UICollectionViewCell() }
            
            cell.designCell(transition: SearchColor.allCases[indexPath.item], selectedCell: viewModel.inputColor.value)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == imageCollectionView {
            let vc = DetailViewController()
            vc.viewModel.inputDetailPhoto.value = viewModel.outputResult.value[indexPath.item]
            
            vc.likeChange = { () in
                self.imageCollectionView.reloadItems(at: [IndexPath(item: indexPath.item, section: 0)])
            }
            
            transitionScreen(vc: vc, style: .push)
            
        } else {
            viewModel.inputColor.value = SearchColor.allCases[indexPath.item]
            colorCollectionView.reloadData()
        }
    }
    
}

extension PhotoSearchViewController: UICollectionViewDelegateFlowLayout {
    private func imageCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 27) / 2
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
    
    private func colorCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 30)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension PhotoSearchViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if viewModel.outputResult.value.count - 4 == item.row {
                viewModel.inputPage.value = ()
            }
        }
    }
    
}

extension PhotoSearchViewController {

    @objc func likeButtonClicked(_ sender: UIButton) {
        print(#function)
        viewModel.inputLike.value = viewModel.outputResult.value[sender.tag]
        
        UIView.performWithoutAnimation {
            imageCollectionView.reloadItems(at: [IndexPath(item: sender.tag, section: 0)])
        }
    }
    
    @objc func arrayButtonClicked() {
        viewModel.inputArrayButton.value = ()
    }
    
    private func bindData() {
        
        viewModel.outputResult.bind { [weak self] value in
            if value.count == 0 {
                self?.searchStatusLabel.text = "검색 결과가 없어요."
                self?.imageCollectionView.isHidden = true
            } else {
                self?.imageCollectionView.reloadData()
                self?.imageCollectionView.isHidden = false
            }
        }
        
        viewModel.outputArrayButton.bind { [weak self] value in
            self?.arrayButton.setTitle(value.title, for: .normal)
        }
        
        viewModel.outputScrollToTop.bind { [weak self] value in
            guard let value else { return }
            self?.imageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        
    }
}
