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
        view.backgroundColor = UIColor.rgb(red: 255, green: 228, blue: 182)
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
        let homeViewController = templateNavController(unselectedImage: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"), title: "홈", rootViewController: HomeViewController())
        let notificationViewController = templateNavController(unselectedImage: UIImage(systemName: "bell"), selectedImage: UIImage(systemName: "bell.fill"), title: "Notice", rootViewController: NotificationViewController())
        let bookMarkViewController = templateNavController(unselectedImage: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"), title: "BookMark", rootViewController: BookMarkViewController())
        let myPageViewController = templateNavController(unselectedImage: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"), title: "MyPage", rootViewController: MyPageViewController())
        
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
            
//            // Remove the line
//            if #available(iOS 13.0, *) {
//                let appearance = self.tabBar.standardAppearance
//                appearance.shadowImage = nil
//                appearance.shadowColor = nil
//                self.tabBar.standardAppearance = appearance
//            } else {
//                self.tabBar.shadowImage = UIImage()
//                self.tabBar.backgroundImage = UIImage()
//            }
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


