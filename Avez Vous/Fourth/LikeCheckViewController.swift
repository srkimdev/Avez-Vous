//
//  LikeCheckViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit
import RxSwift

final class LikeCheckViewController: BaseViewController {
    
    let arrayButton = ArrayButton(title: CustomDesign.Buttons.latest)
    let searchStatusLabel = UILabel()
    
    let viewModel = LikeCheckViewModel()
    let disposeBag = DisposeBag()
    let showList = PublishSubject<Void>()
    
    lazy var colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: colorCollectionViewLayout())
    lazy var likeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: likeCheckCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeCollectionView.register(LikeCheckCollectionViewCell.self, forCellWithReuseIdentifier: LikeCheckCollectionViewCell.identifier)
//        colorCollectionView.register(PhotoSearchColorCollectionViewCell.self, forCellWithReuseIdentifier: PhotoSearchColorCollectionViewCell.identifier)
        
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showList.onNext(())
    }
    
    override func configureHierarchy() {
        view.addSubview(colorCollectionView)
        view.addSubview(arrayButton)
        view.addSubview(searchStatusLabel)
        view.addSubview(likeCollectionView)
    }
    
    override func configureLayout() {
        
        arrayButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(30)
            make.width.equalTo(70)
        }
        
        colorCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(arrayButton.snp.leading)
            make.height.equalTo(30)
        }
        
        likeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(colorCollectionView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(4)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchStatusLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeCollectionView)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        navigationItem.title = CustomDesign.NavigationTitle.likestore
        
        searchStatusLabel.text = CustomDesign.Placeholder.noStore
        searchStatusLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        likeCollectionView.isHidden = true
    }
    
}

extension LikeCheckViewController: UICollectionViewDelegateFlowLayout {
    private func likeCheckCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 11) / 2
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

extension LikeCheckViewController {
    
    private func bindData() {
        
        let likeButtonTap = PublishSubject<DBTable>()
        
        let input = LikeCheckViewModel.Input(showList: showList, arrayButton: arrayButton.rx.tap, likeButton: likeButtonTap)
        let output = viewModel.transform(input: input)
        
        output.imageInfoList
            .drive(likeCollectionView.rx.items(cellIdentifier: LikeCheckCollectionViewCell.identifier, cellType: LikeCheckCollectionViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: element)
                
                cell.likeButton.rx.tap
                    .bind(with: self) { owner, _ in
                        likeButtonTap.onNext(element)
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
            
        output.imageInfoList
            .drive(with: self) { owner, value in
                if value.count == 0 {
                    owner.searchStatusLabel.text = CustomDesign.Placeholder.noStore
                    owner.likeCollectionView.isHidden = true
                } else {
                    owner.likeCollectionView.isHidden = false
                }
                
            }
            .disposed(by: disposeBag)
        
        likeCollectionView.rx.modelSelected(DBTable.self)
            .bind(with: self) { owner, value in
                let vc = DetailViewController()
                vc.hidesBottomBarWhenPushed
                vc.viewModel.inputFromLike.value = value
                
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        
        output.arrayButtonName
            .bind(with: self) { owner, value in
                owner.arrayButton.setTitle(value.title, for: .normal)
            }
            .disposed(by: disposeBag)
        
    }
    
}

