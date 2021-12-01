//
//  ViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/15.
//

import UIKit
import Firebase
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            let isInitial = UserDefaults.standard.string(forKey: "isInitial")
            if isInitial != "yes" {
                let viewController = GuideViewController()
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            } else {
                let viewController = LoginViewController()
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            }
            
            
        }
    }
    
}

