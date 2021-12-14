//
//  ExtraModifyViewController.swift
//  Knowing
//
//  Created by Jun on 2021/12/14.
//

import UIKit
import RxSwift
import RxCocoa

class ExtraModifyViewController: UIViewController {

    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let titleLb = UILabel().then {
        $0.text = "회원 정보 설정"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "GodoM", size: 23)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    

}
