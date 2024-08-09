//
//  RandomPictureViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RandomPictureViewController: BaseViewController {
    
    lazy var imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: imageCollectionViewLayout())
    
    private let refreshControl = UIRefreshControl()
    
    let viewModel = RandomPictureViewModel()
    let disposeBag = DisposeBag()
    let pullToRefresh = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.showsVerticalScrollIndicator = false
        imageCollectionView.register(RandomPictureCollectionViewCell.self, forCellWithReuseIdentifier: RandomPictureCollectionViewCell.identifier)
        imageCollectionView.refreshControl = refreshControl
        
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

    @objc func refreshData() {
        
        if !NetworkManager.shared.isNetworkAvailable() {
            NetworkManager.shared.showToast(message: CustomDesign.ToastMessage.noConnected)
            refreshControl.endRefreshing()
            return
        }
        
        pullToRefresh.onNext(())
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.refreshControl.endRefreshing()
            self.imageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    private func bindData() {
        
        let callRequest = PublishSubject<Void>()
        let likeButtonTap = PublishSubject<Photos>()
        
        let input = RandomPictureViewModel.Input(callRequest: callRequest, pullToRefresh: self.pullToRefresh, likeButtonTap: likeButtonTap)
        let output = viewModel.transform(input: input)
        
        callRequest.onNext(())
        
        output.imageList
            .drive(imageCollectionView.rx.items(cellIdentifier: RandomPictureCollectionViewCell.identifier, cellType: RandomPictureCollectionViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: element)
                
                cell.likeButton.rx.tap
                    .bind(with: self) { owner, _ in
                        likeButtonTap.onNext(element)
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        output.imageList
            .drive(with: self) { owner, value in
                if value.count == 10 {
                    owner.imageCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
                }
            }
            .disposed(by: disposeBag)
        
        output.reloadData
            .bind(with: self) { owner, _ in
                owner.imageCollectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        imageCollectionView.rx.modelSelected(Photos.self)
            .bind(with: self) { owner, value in
                
                let vc = DetailViewController()
                vc.hidesBottomBarWhenPushed = true
                vc.showImageInfoFromSearch.onNext(value)
                
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
}
