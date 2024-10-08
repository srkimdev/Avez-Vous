//
//  TopicTrendTableViewCell.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit
import RxSwift

final class TopicTrendTableViewCell: BaseTableViewCell {
    
    let titleLabel = UILabel()
    let imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageCollectionView.register(TopicTrendCollectionViewCell.self, forCellWithReuseIdentifier: TopicTrendCollectionViewCell.identifier)
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageCollectionView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(4)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(20)
        }
        
        imageCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    override func configureUI() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .heavy)
    }
    
    func designName(transition: String) {
        titleLabel.text = transition
    }
    
    func designCell(transition: [Photos]) {
        Observable.just(transition)
            .bind(to: imageCollectionView.rx.items(cellIdentifier: TopicTrendCollectionViewCell.identifier, cellType: TopicTrendCollectionViewCell.self)) { (item, element, cell) in
                
                cell.designCell(transition: element)
                
            }
            .disposed(by: disposeBag)
    }
    
}


