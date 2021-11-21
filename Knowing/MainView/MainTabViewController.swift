//
//  MainTabViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/20.
//

import Foundation
import UIKit

class MainTabViewController: UITabBarController {
    
    let customTabBarView = UIView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 255, green: 245, blue: 230)
        setupTabBarUI()
        addCustomTabBarView()
        setupViewControllers()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupCustomTabBarFrame()
    }
    
    
    func setupViewControllers() {
        let homeViewController = templateNavController(unselectedImage: UIImage(named: "home_unselected"), selectedImage: UIImage(named: "home_selected"), title: "홈", rootViewController: HomeViewController())
        let notificationViewController = templateNavController(unselectedImage: UIImage(named: "alarm_unselected"), selectedImage: UIImage(named: "alarm_selected"), title: "알림 내역", rootViewController: NotificationViewController())
        let bookMarkViewController = templateNavController(unselectedImage: UIImage(named: "bookmark_unselected"), selectedImage: UIImage(named: "bookmark_unselected"), title: "북마크", rootViewController: BookMarkViewController())
        let myPageViewController = templateNavController(unselectedImage: UIImage(named: "mypage_unselected"), selectedImage: UIImage(named: "mypage_selected"), title: "마이페이지", rootViewController: MyPageViewController())
        
        viewControllers = [homeViewController, notificationViewController, bookMarkViewController, myPageViewController]
        
        
        
        if let items = tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
            }
        }
        
    }
    
    private func setupCustomTabBarFrame() {
            let height = self.view.safeAreaInsets.bottom + 57
            
            var tabFrame = self.tabBar.frame
            tabFrame.size.height = height
            tabFrame.origin.y = self.view.frame.size.height - height
            
            self.tabBar.frame = tabFrame
            self.tabBar.setNeedsLayout()
            self.tabBar.layoutIfNeeded()
            customTabBarView.frame = tabBar.frame
        }
        
        private func setupTabBarUI() {
            // Setup your colors and corner radius
            tabBar.layer.masksToBounds = true
            tabBar.isTranslucent = false
            self.tabBar.barTintColor = UIColor.rgb(red: 250, green: 239, blue: 221)
            self.tabBar.layer.cornerRadius = 30
            self.tabBar.layer.borderWidth = 1.5
            self.tabBar.layer.borderColor = CGColor.init(red: 233 / 255, green: 206 / 255, blue: 181 / 255, alpha: 1.0)
            self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.tabBar.backgroundColor = .clear
            self.tabBar.tintColor = UIColor.rgb(red: 204, green: 108, blue: 45)
            self.tabBar.unselectedItemTintColor = UIColor.rgb(red: 205, green: 153, blue: 117)
            self.tabBar.itemSpacing = 34
            
            
        }
        
        private func addCustomTabBarView() {
            customTabBarView.layer.masksToBounds = true
            
            self.customTabBarView.frame = tabBar.frame
            self.customTabBarView.backgroundColor = UIColor.rgb(red: 250, green: 239, blue: 221)
            self.customTabBarView.layer.cornerRadius = 30
            self.customTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
            self.customTabBarView.layer.borderWidth = 1.0
            self.customTabBarView.layer.borderColor = CGColor.init(red: 233 / 255, green: 206 / 255, blue: 181 / 255, alpha: 1.0)
            self.view.addSubview(customTabBarView)
            self.view.bringSubviewToFront(self.tabBar)
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


