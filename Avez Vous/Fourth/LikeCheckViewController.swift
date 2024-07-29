//
//  LikeCheckViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit

final class LikeCheckViewController: BaseViewController {
    
    let arrayButton = ArrayButton(title: CustomDesign.Buttons.latest)
    let searchStatusLabel = UILabel()
    
    let viewModel = LikeCheckViewModel()
    
    lazy var colorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: colorCollectionViewLayout())
    lazy var likeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: likeCheckCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeCollectionView.delegate = self
        likeCollectionView.dataSource = self
        likeCollectionView.register(LikeCheckCollectionViewCell.self, forCellWithReuseIdentifier: LikeCheckCollectionViewCell.identifier)
        
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        colorCollectionView.register(PhotoSearchColorCollectionViewCell.self, forCellWithReuseIdentifier: PhotoSearchColorCollectionViewCell.identifier)
        
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.showLikeList.value = ()
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
    
    override func configureAction() {
        arrayButton.addTarget(self, action: #selector(arrayButtonClicked), for: .touchUpInside)
    }
    
}

extension LikeCheckViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == likeCollectionView {
            return viewModel.outputResult.value.count
        } else {
            return SearchColor.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == likeCollectionView {
            guard let cell = likeCollectionView.dequeueReusableCell(withReuseIdentifier: LikeCheckCollectionViewCell.identifier, for: indexPath) as? LikeCheckCollectionViewCell else { return UICollectionViewCell() }
            
            cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
            cell.likeButton.tag = indexPath.item
            cell.designCell(transition: viewModel.outputImageFiles.value[indexPath.item])
            
            return cell
            
        } else {
            guard let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoSearchColorCollectionViewCell.identifier, for: indexPath) as? PhotoSearchColorCollectionViewCell else { return UICollectionViewCell() }
            
            cell.designCell(transition: SearchColor.allCases[indexPath.item], selectedCell: viewModel.inputColor.value)
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == likeCollectionView {
            let vc = DetailViewController()
            vc.viewModel.inputFromLike.value = viewModel.outputResult.value[indexPath.item]
            
            transitionScreen(vc: vc, style: .push)
            
        } else {
            colorCollectionView.reloadData()
        }
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

    @objc func likeButtonClicked(_ sender: UIButton) {
        viewModel.inputLike.value = viewModel.outputResult.value[sender.tag]
        likeCollectionView.reloadData()
    }
    
    @objc func arrayButtonClicked() {
        viewModel.inputArrayButton.value = ()
    }
    
    private func bindData() {
        
        viewModel.outputResult.bind { [weak self] value in
            if value.count == 0 {
                self?.searchStatusLabel.text = CustomDesign.Placeholder.noStore
                self?.likeCollectionView.isHidden = true
            } else {
                self?.likeCollectionView.reloadData()
                self?.likeCollectionView.isHidden = false
            }
        }
        
        viewModel.outputArrayButton.bind { [weak self] value in
            self?.arrayButton.setTitle(value.title, for: .normal)
        }
        
    }
}

