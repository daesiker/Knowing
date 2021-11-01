//
//  DefaultLoginViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/28.
//

import UIKit

class DefaultLoginViewController: UIViewController {

    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let titleLb = UILabel().then {
        $0.text = "로그인"
        $0.font = UIFont(name: "GodoM", size: 24)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
    }
    
    let emailLabel = UILabel().then {
        $0.text = "이메일"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let emailTextField = CustomTextField(image: UIImage(named: "email")!, text: "이메일 주소 입력").then {
        $0.backgroundColor = UIColor.rgb(red: 243, green: 243, blue: 243)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
    }
    
    let pwLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let pwTextField = CustomTextField(image: UIImage(named: "password")!, text: "영문자와 숫자 포함 8자 이상 입력").then {
        $0.backgroundColor = UIColor.rgb(red: 243, green: 243, blue: 243)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
    }
    
    let logInBt = UIButton(type: .custom).then {
        $0.setTitle("로그인하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.rgb(red: 177, green: 177, blue: 177)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 128, bottom: 14, right: 127)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    

}

extension DefaultLoginViewController {
    func setUI() {
        safeArea.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(20)
        }
        
        safeArea.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(26)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(emailLabel)
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(37)
            $0.leading.equalToSuperview().offset(24)
        }
        
        safeArea.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.top.equalTo(emailLabel.snp.bottom).offset(9)
        }
        
        safeArea.addSubview(pwLabel)
        pwLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(31)
            $0.leading.equalToSuperview().offset(24)
        }
        
        safeArea.addSubview(pwTextField)
        pwTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.top.equalTo(pwLabel.snp.bottom).offset(9)
        }
        
        safeArea.addSubview(logInBt)
        logInBt.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(35)
            $0.centerX.equalToSuperview()
        }
        
    }
}
