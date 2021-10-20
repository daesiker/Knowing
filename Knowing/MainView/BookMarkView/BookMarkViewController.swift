//
//  BookMarkViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/20.
//

import UIKit
import Foundation
import Then

class BookMarkViewController: UIViewController {

    let textField = UITextView().then {
        $0.text = "BookMarkViewController"
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
