//
//  ConfirmPasswordViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/10.
//

import UIKit
import Lottie
import RxSwift
import RxCocoa

class ConfirmPasswordViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let animationView = AnimationView(name: "lf30_editor_ctu3nzol").then {
        $0.contentMode = .scaleAspectFill
    }
    
    let largeLb = UILabel().then {
        $0.text = "메일 전송 완료!"
        $0.font = UIFont(name: "GodoM", size: 22)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
    }
    
    let subTitle1 = UILabel().then {
        $0.text = "이메일 링크를 클릭하여"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.textColor = UIColor.rgb(red: 147, green: 147, blue: 147)
    }
    
    let subTitle2 = UILabel().then {
        $0.text = "비밀번호를 재설정 해주세요."
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.textColor = UIColor.rgb(red: 147, green: 147, blue: 147)
    }
    
    let confirmBt = UIButton(type: .custom).then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 149, bottom: 15, right: 148)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.play()
        animationView.loopMode = .loop
        setUI()
        bind()
        
    }

}

extension ConfirmPasswordViewController {
    
    func setUI() {
        view.backgroundColor = .white
        safeArea.addSubview(confirmBt)
        confirmBt.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-22)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        safeArea.addSubview(subTitle2)
        subTitle2.snp.makeConstraints {
            $0.bottom.equalTo(confirmBt.snp.top).offset(-188)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(subTitle1)
        subTitle1.snp.makeConstraints {
            $0.bottom.equalTo(subTitle2.snp.top).offset(-6)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(largeLb)
        largeLb.snp.makeConstraints {
            $0.bottom.equalTo(subTitle1.snp.top).offset(-19)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(animationView)
        animationView.snp.makeConstraints {
            $0.bottom.equalTo(largeLb.snp.top).offset(-23)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(174)
            $0.height.equalTo(176)
        }
        
    }
    
    func bind() {
        confirmBt.rx.tap.subscribe(onNext: {
            let viewController = LoginViewController()
            let navController = UINavigationController(rootViewController: viewController)
            navController.isNavigationBarHidden = true
            navController.modalTransitionStyle = .crossDissolve
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true)
        }).disposed(by: disposeBag)
    }
}
