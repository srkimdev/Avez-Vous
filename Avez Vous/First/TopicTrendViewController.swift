//
//  TopicTrendViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit
import Toast

final class TopicTrendViewController: BaseViewController {
    
    let rightBarButtonView = UIView()
    let rightBarButton = UIButton()
    let titleLabel = UILabel()
    
    let topicTableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    let viewModel = TopicTrendViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicTableView.delegate = self
        topicTableView.dataSource = self
        topicTableView.register(TopicTrendTableViewCell.self, forCellReuseIdentifier: TopicTrendTableViewCell.identifier)
        topicTableView.rowHeight = 250
        topicTableView.refreshControl = refreshControl
        
//        viewModel.inputAPIRequest.value = ()
        view.makeToastActivity(.center)
        
        bindData()
    }
    
    override func configureHierarchy() {
        view.addSubview(rightBarButtonView)
        rightBarButtonView.addSubview(rightBarButton)
        view.addSubview(titleLabel)
        view.addSubview(topicTableView)
    }
    
    override func configureLayout() {
        
        rightBarButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(40)
        }
        
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
        
        let item = UIBarButtonItem(customView: rightBarButtonView)
        navigationItem.rightBarButtonItem = item
        
        rightBarButton.setImage(UIImage(named: "profile_\(UserInfo.shared.profileNumber)"), for: .normal)
        rightBarButton.layer.cornerRadius = 20
        rightBarButton.layer.borderWidth = 3
        rightBarButton.layer.borderColor = CustomDesign.Colors.Blue.cgColor
        rightBarButton.layer.masksToBounds = true
        
        topicTableView.separatorStyle = .none
        
        titleLabel.text = "OUR TOPIC"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        
    }
    
    override func configureAction() {
        rightBarButton.addTarget(self, action: #selector(profileButtonClicked), for: .touchUpInside)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

}

extension TopicTrendViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputTableView.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = topicTableView.dequeueReusableCell(withIdentifier: TopicTrendTableViewCell.identifier, for: indexPath) as? TopicTrendTableViewCell else { return UITableViewCell() }
        
        cell.imageCollectionView.delegate = self
        cell.imageCollectionView.dataSource = self
        cell.imageCollectionView.tag = indexPath.row
        cell.imageCollectionView.register(TopicTrendCollectionViewCell.self, forCellWithReuseIdentifier: TopicTrendCollectionViewCell.identifier)
        cell.imageCollectionView.reloadData()
        
        cell.designCell(transition: viewModel.randomTopics![indexPath.row].description)
        
        return cell
    }
    
}

extension TopicTrendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputTableView.value[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopicTrendCollectionViewCell.identifier, for: indexPath) as? TopicTrendCollectionViewCell else { return UICollectionViewCell() }
        
        cell.designCell(transition: viewModel.outputTableView.value[collectionView.tag][indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.inputFromSearch.value = viewModel.outputTableView.value[collectionView.tag][indexPath.item]
        
        transitionScreen(vc: vc, style: .push)
    }
    
}

extension TopicTrendViewController {
    
    @objc func profileButtonClicked() {
        let vc = ProfileSettingViewController()
        
        vc.selectedClosure = { [weak self] value in
            self?.rightBarButton.setImage(UIImage(named: "profile_\(UserInfo.shared.profileNumber)"), for: .normal)
        }
        
        transitionScreen(vc: vc, style: .push)
    }
    
    @objc func refreshData() {
        
        if !NetworkManager.shared.isNetworkAvailable() {
            NetworkManager.shared.showToast(message: "인터넷에 연결되지 않았습니다.\n연결 확인 후 다시 시도해 주세요.")
            refreshControl.endRefreshing()
            return
        }
        
        self.viewModel.inputAPIRequest.value = ()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.refreshControl.endRefreshing()
        }
    }

    private func bindData() {
        viewModel.outputTableView.bind { [weak self] value in
            guard value.count == 3 else { return }
            self?.topicTableView.reloadData()
            self?.view.hideToastActivity()
        }
    }
    
    
}
