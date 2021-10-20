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
        setupViewControllers()
    }
    
    func setupViewControllers() {
        let homeViewController = templateNavController(unselectedImage: UIImage(named: ""), selectedImage: UIImage(named: ""), title: "", rootViewController: HomeViewController())
        let notificationViewController = templateNavController(unselectedImage: UIImage(systemName: ""), selectedImage: UIImage(named: ""), title: "", rootViewController: NotificationViewController())
        let bookMarkViewController = templateNavController(unselectedImage: UIImage(systemName: ""), selectedImage: UIImage(named: ""), title: "", rootViewController: BookMarkViewController())
        let myPageViewController = templateNavController(unselectedImage: UIImage(systemName: ""), selectedImage: UIImage(named: ""), title: "", rootViewController: MyPageViewController())
        
        viewControllers = [homeViewController, notificationViewController, bookMarkViewController, myPageViewController]
        
        if let items = tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
            }
        }
        
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage?, selectedImage: UIImage?, title: String, rootViewController: UIViewController) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
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


