//
//  ConfirmEmailViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/10.
//

import UIKit
import Lottie
import RxCocoa
import RxSwift

class ConfirmEmailViewController: UIViewController {

    let disposeBag = DisposeBag()
    var name = "oo"
    var email = "example@example.com"
    
    let animationView = AnimationView(name: "lf20_rjrqsjob").then {
        $0.contentMode = .scaleAspectFill
    }
    
    let largeLb = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "GodoM", size: 22)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
    }
    
    let emailLb = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "GodoM", size: 22)
        $0.textColor = UIColor.rgb(red: 255, green: 136, blue: 84)
    }
    
    let subLb = UILabel().then {
        $0.text = "개인정보 보호를 위해 이메일 끝자리는 *로 표시하였습니다."
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        $0.textColor = UIColor.rgb(red: 147, green: 147, blue: 147)
    }
    
    let goFindPwBt = UIButton(type: .custom).then {
        $0.setTitle("비밀번호 재설정하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.setTitleColor(UIColor.rgb(red: 169, green: 169, blue: 169), for: .normal)
        $0.titleEdgeInsets.top = 9
        $0.titleEdgeInsets.bottom = 8
        $0.titleEdgeInsets.left = 17
        $0.titleEdgeInsets.right = 16
    }
    
    let goLoginBt = UIButton(type: .custom).then {
        $0.setTitle("로그인 하러가기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 112, bottom: 14, right: 111)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue()
        setUI()
        bind()
    }
    
    func setValue() {
        animationView.play()
        animationView.loopMode = .loop
        largeLb.text = "\(name)님의 이메일을 찾았어요!"
        emailLb.text = email
    }
    
}

extension ConfirmEmailViewController {
    func setUI() {
        view.backgroundColor = .white
        safeArea.addSubview(animationView)
        animationView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(219)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(125)
            $0.height.equalTo(123)
        }
        
        safeArea.addSubview(largeLb)
        largeLb.snp.makeConstraints {
            $0.top.equalTo(animationView.snp.bottom).offset(33)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(emailLb)
        emailLb.snp.makeConstraints {
            $0.top.equalTo(largeLb.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(subLb)
        subLb.snp.makeConstraints {
            $0.top.equalTo(emailLb.snp.bottom).offset(21)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(goLoginBt)
        goLoginBt.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-22)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        safeArea.addSubview(goFindPwBt)
        goFindPwBt.snp.makeConstraints {
            $0.bottom.equalTo(goLoginBt.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset(114)
            $0.trailing.equalToSuperview().offset(-114)
        }
        
    }
    
    func bind() {
        goFindPwBt.rx.tap
            .subscribe(onNext: {
                let vc = FindPasswordViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
        goLoginBt.rx.tap.subscribe(onNext: {
            let viewController = LoginViewController()
            let navController = UINavigationController(rootViewController: viewController)
            navController.isNavigationBarHidden = true
            navController.modalTransitionStyle = .crossDissolve
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true)
        }).disposed(by: disposeBag)
        
        
    }
}
