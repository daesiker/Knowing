//
//  NotificationViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/20.
//

import UIKit
import Foundation
import Then

class NotificationViewController: UIViewController {

    let textField = UITextView().then {
        $0.text = "NotificationViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(textField)
        textField.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        // Do any additional setup after loading the view.
    }
    

    
}

