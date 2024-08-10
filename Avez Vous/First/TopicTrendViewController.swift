//
//  TopicTrendViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit
import SnapKit
import Toast
import RxSwift
import RxCocoa

final class TopicTrendViewController: BaseViewController {
    
    let rightBarButtonView = UIView()
    let rightBarButton = UIButton()
    let titleLabel = UILabel()
    
    let topicTableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    let pullToRefresh = PublishSubject<Void>()
    let viewModel = TopicTrendViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicTableView.register(TopicTrendTableViewCell.self, forCellReuseIdentifier: TopicTrendTableViewCell.identifier)
        topicTableView.refreshControl = refreshControl
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
        rightBarButton.layer.borderWidth = CustomDesign.BorderWidths.Width3
        rightBarButton.layer.borderColor = CustomDesign.Colors.Blue.cgColor
        rightBarButton.layer.masksToBounds = true
        
        topicTableView.separatorStyle = .none
        topicTableView.rowHeight = 250
        
        titleLabel.text = CustomDesign.Name.topic
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
    }
    
    override func configureAction() {
        rightBarButton.addTarget(self, action: #selector(profileButtonClicked), for: .touchUpInside)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
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
        
        // network check
        if !NetworkManager.shared.isNetworkAvailable() {
            NetworkManager.shared.showToast(message: CustomDesign.ToastMessage.noConnected)
            refreshControl.endRefreshing()
            return
        }
        
        // API request
        pullToRefresh.onNext(())
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.refreshControl.endRefreshing()
        }

    }

    private func bindData() {
        
        let callRequest = PublishSubject<Void>()

        let input = TopicTrendViewModel.Input(callRequest: callRequest, pullToRefresh: self.pullToRefresh)
        let output = viewModel.transform(input: input)

        callRequest.onNext(())
        
        output.tableViewList
            .drive(topicTableView.rx.items(cellIdentifier: TopicTrendTableViewCell.identifier, cellType: TopicTrendTableViewCell.self)) { (row, element, cell) in

                cell.designName(transition: self.viewModel.randomTopics![row].description)
                cell.designCell(transition: element)
                
                cell.imageCollectionView.rx.modelSelected(Photos.self)
                    .bind(with: self) { owner, value in
                        
                        let vc = DetailViewController()
                        vc.hidesBottomBarWhenPushed = true
                        
                        vc.showImageInfoFromSearch.onNext(value)
                        owner.navigationController?.pushViewController(vc, animated: true)
                    }
                    .disposed(by: cell.disposeBag)
                
            }
            .disposed(by: disposeBag)
        
        output.tableViewList
            .drive(with: self) { owner, value in
                if value.count == 3 {
                    owner.view.hideToastActivity()
                }
            }
            .disposed(by: disposeBag)
        
    }
    
}

