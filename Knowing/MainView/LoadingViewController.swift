//
//  LoadingViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/22.
//

import UIKit
import Lottie
import Then

class LoadingViewController: UIViewController {

    let animationView = AnimationView(name: "lf20_ng9j9lpx_1").then {
        
        $0.contentMode = .scaleAspectFit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        view.addSubview(animationView)
        animationView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalToSuperview().multipliedBy(0.4)
        }
        animationView.play()
        animationView.loopMode = .loop
    }
    
    

}
