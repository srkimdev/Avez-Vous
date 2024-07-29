//
//  RandomPictureViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit

final class RandomPictureViewController: BaseViewController {
    
    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: imageCollectionViewLayout())
    
    let refreshControl = UIRefreshControl()
    let viewModel = RandomPictureViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(RandomPictureCollectionViewCell.self, forCellWithReuseIdentifier: RandomPictureCollectionViewCell.identifier)
        imageCollectionView.showsVerticalScrollIndicator = false
        imageCollectionView.refreshControl = refreshControl
        
        viewModel.inputRandomImage.value = ()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func configureHierarchy() {
        view.addSubview(imageCollectionView)
    }
    
    override func configureLayout() {
        imageCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0)
        }
    }
    
    override func configureAction() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
}

extension RandomPictureViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputRandomImage.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: RandomPictureCollectionViewCell.identifier, for: indexPath) as? RandomPictureCollectionViewCell else { return UICollectionViewCell() }
        
        cell.designCell(transition: viewModel.outputRandomImage.value[indexPath.item])
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        cell.likeButton.tag = indexPath.item
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.inputFromSearch.value = viewModel.outputRandomImage.value[indexPath.item]
        
        transitionScreen(vc: vc, style: .push)
    }
    
}

extension RandomPictureViewController: UICollectionViewDelegateFlowLayout {
    private func imageCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - (tabBarController?.tabBar.frame.height ?? 0))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
}

extension RandomPictureViewController {
    
    @objc func likeButtonClicked(_ sender: UIButton) {
        viewModel.inputLike.value = viewModel.outputRandomImage.value[sender.tag]
    }
    
    @objc func refreshData() {
        
        if !NetworkManager.shared.isNetworkAvailable() {
            NetworkManager.shared.showToast(message: CustomDesign.ToastMessage.noConnected)
            refreshControl.endRefreshing()
            return
        }
        
        viewModel.inputRandomImage.value = ()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func bindData() {
        viewModel.outputRandomImage.bind { [weak self] value in
            self?.imageCollectionView.reloadData()
        }
        
        viewModel.scrollToTop.bind { [weak self] value in
            guard let value else { return }
            self?.imageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        
        viewModel.outputLike.bind { [weak self] value in
            guard let value else { return }
            self?.imageCollectionView.reloadData()
        }
        
    }
    
}
