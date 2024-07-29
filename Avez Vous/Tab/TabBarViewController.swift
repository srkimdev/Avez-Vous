//
//  TabBarViewController.swift
//  Avez Vous
//
//  Created by 김성률 on 7/23/24.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let first = TopicTrendViewController()
        let nav1 = UINavigationController(rootViewController: first)
        nav1.tabBarItem = UITabBarItem(title: nil, image: CustomDesign.Images.trendInactive, selectedImage: CustomDesign.Images.trend)
        
        let second = RandomPictureViewController()
        let nav2 = UINavigationController(rootViewController: second)
        nav2.tabBarItem = UITabBarItem(title: nil, image: CustomDesign.Images.randomInactive, selectedImage: CustomDesign.Images.random)
        
        let third = PhotoSearchViewController()
        let nav3 = UINavigationController(rootViewController: third)
        nav3.tabBarItem = UITabBarItem(title: nil, image: CustomDesign.Images.searchInactive, selectedImage: CustomDesign.Images.search)
        
        let fourth = LikeCheckViewController()
        let nav4 = UINavigationController(rootViewController: fourth)
        nav4.tabBarItem = UITabBarItem(title: nil, image: CustomDesign.Images.tabLikeInactive, selectedImage: CustomDesign.Images.tabLike)
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
    
}
