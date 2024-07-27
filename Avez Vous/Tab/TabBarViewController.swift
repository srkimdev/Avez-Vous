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
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_trend_inactive"), selectedImage: UIImage(named: "tab_trend"))
        
        let second = RandomPictureViewController()
        let nav2 = UINavigationController(rootViewController: second)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_random_inactive"), selectedImage: UIImage(named: "tab_random"))
        
        let third = PhotoSearchViewController()
        let nav3 = UINavigationController(rootViewController: third)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_search_inactive"), selectedImage: UIImage(named: "tab_search"))
        
        let fourth = LikeCheckViewController()
        let nav4 = UINavigationController(rootViewController: fourth)
        nav4.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "tab_like_inactive"), selectedImage: UIImage(named: "tab_like"))
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
    
}
