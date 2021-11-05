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
        $0.contentMode = .scaleAspectFill
    }
    
    let largeTitleLabel = UILabel().then {
        $0.attributedText = NSAttributedString(string: "00님의 복지 수혜 예상\n금액을 계산중이에요!").withLineSpacing(6)
        $0.font = UIFont(name: "GodoM", size: 22)
        $0.textColor = UIColor.rgb(red: 185, green: 113, blue: 66)
        $0.numberOfLines = 2
    }
    
    let smallTitleLabel = UILabel().then {
        $0.text = "잠시만 기다려 주세요."
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.textColor = UIColor.rgb(red: 210, green: 132, blue: 81)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.play()
        animationView.loopMode = .loop
        setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        view.backgroundColor = UIColor.rgb(red: 255, green: 225, blue: 182)
        safeArea.addSubview(animationView)
        animationView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(205)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(211)
            $0.height.equalTo(221)
        }
        
        safeArea.addSubview(largeTitleLabel)
        largeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(animationView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(73)
            $0.trailing.equalToSuperview().offset(73)
        }
        
        safeArea.addSubview(smallTitleLabel)
        smallTitleLabel.snp.makeConstraints {
            $0.top.equalTo(largeTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(116)
            $0.trailing.equalToSuperview().offset(-115)
        }
        
    }
    
    

}
