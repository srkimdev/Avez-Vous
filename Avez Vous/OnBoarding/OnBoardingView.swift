//
//  OnBoardingView.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import UIKit
import SnapKit

final class OnBoardingView: BaseView {
    
    private let titleLabel = UILabel()
    private let imageLabel = UIImageView()
    private let nameLabel = UILabel()
    let startButton = UIButton()
    
    override func configureHierarchy() {
        [titleLabel, imageLabel, nameLabel, startButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        imageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(45)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            make.height.equalTo(340)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageLabel.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(40)
        }
    }
    
    override func configureUI() {
        titleLabel.text = CustomDesign.Name.appName
        titleLabel.textColor = CustomDesign.Colors.Blue
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 40, weight: .heavy)
        
        imageLabel.image = CustomDesign.Images.launchImage
        
        nameLabel.text = CustomDesign.Name.userName
        nameLabel.textAlignment = .center
        nameLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        
        startButton.setTitle(CustomDesign.Buttons.start, for: .normal)
        startButton.setTitleColor(CustomDesign.Colors.White, for: .normal)
        startButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        startButton.backgroundColor = CustomDesign.Colors.Blue
        startButton.layer.masksToBounds = true
        startButton.layer.cornerRadius = 20
    }
    
}
