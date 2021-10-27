//
//  MainTabViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/20.
//

import Foundation
import UIKit

class MainTabViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.barTintColor = UIColor.orange //탭바 배경색
        tabBar.isTranslucent = false //탭바 투명도
        setupViewControllers()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
    func setupViewControllers() {
        let homeViewController = templateNavController(unselectedImage: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"), title: "Home", rootViewController: HomeViewController())
        let notificationViewController = templateNavController(unselectedImage: UIImage(systemName: "bell"), selectedImage: UIImage(systemName: "bell.fill"), title: "Notice", rootViewController: NotificationViewController())
        let bookMarkViewController = templateNavController(unselectedImage: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"), title: "BookMark", rootViewController: BookMarkViewController())
        let myPageViewController = templateNavController(unselectedImage: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"), title: "MyPage", rootViewController: MyPageViewController())
        
        viewControllers = [homeViewController, notificationViewController, bookMarkViewController, myPageViewController]
        
        if let items = tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
            }
        }
        
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage?, selectedImage: UIImage?, title: String, rootViewController: UIViewController) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        if let selectedImage = selectedImage, let unselectedImage = unselectedImage {
            navController.tabBarItem.image = unselectedImage
            navController.tabBarItem.selectedImage = selectedImage
        }
        
        
        return navController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    
}


