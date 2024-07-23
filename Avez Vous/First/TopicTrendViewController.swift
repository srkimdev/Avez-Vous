//
//  TopicTrendViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit

final class TopicTrendViewController: BaseViewController {
    
    let titleLabel = UILabel()
    let topicTableView = UITableView()
//    var imageList: [[PosterPath]] = [
    //                                    [PosterPath(poster_path: "")],
    //                                    [PosterPath(poster_path: "")]
    //                                    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicTableView.delegate = self
        topicTableView.dataSource = self
        topicTableView.register(TopicTrendTableViewCell.self, forCellReuseIdentifier: TopicTrendTableViewCell.identifier)
        topicTableView.rowHeight = 250
        
    }
    
    override func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(topicTableView)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(4)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        topicTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureUI() {
        titleLabel.text = "OUR TOPIC"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
    }
    
    
    
}

extension TopicTrendViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "골든 아워"
//        } else if section == 1 {
//            return "비즈니스 및 업무"
//        } else {
//            return "건축 및 인테리어"
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = topicTableView.dequeueReusableCell(withIdentifier: TopicTrendTableViewCell.identifier, for: indexPath) as? TopicTrendTableViewCell else { return UITableViewCell() }
        
        cell.imageCollectionView.delegate = self
        cell.imageCollectionView.dataSource = self
        cell.imageCollectionView.tag = indexPath.row
        cell.imageCollectionView.register(TopicTrendCollectionViewCell.self, forCellWithReuseIdentifier: TopicTrendCollectionViewCell.identifier)
        //        cell.collectionView.reloadData()
        
        return cell
    }
    
}

extension TopicTrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicTrendCollectionViewCell.identifier, for: indexPath) as? TopicTrendCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}

//extension PosterViewController: UITableViewDelegate, UITableViewDataSource {
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return imageList.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.identifier, for: indexPath) as! PosterTableViewCell
//
//        cell.collectionView.dataSource = self
//        cell.collectionView.delegate = self
//        cell.collectionView.tag = indexPath.row
//        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
//        cell.collectionView.reloadData()
//
//        return cell
//    }
//
//}
//
//extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return imageList[collectionView.tag].count
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
//
//        let data = imageList[collectionView.tag][indexPath.item]
//
//        let url = URL(string: "https://image.tmdb.org/t/p/w780\(data.poster_path ?? "")")
//
//        cell.posterImageView.kf.setImage(with: url)
//
//        return cell
//    }
//
//}
