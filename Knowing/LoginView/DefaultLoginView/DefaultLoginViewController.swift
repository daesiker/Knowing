//
//  DefaultLoginViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/28.
//

import UIKit
import RxSwift
import RxCocoa

class DefaultLoginViewController: UIViewController {
    
    let vm = DefaultLoginViewModel()
    let disposeBag = DisposeBag()
    
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
    
    let emailTextField = CustomTextField(image: UIImage(named: "email")!, text: "이메일 주소 입력", state: .login).then {
        $0.backgroundColor = UIColor.rgb(red: 243, green: 243, blue: 243)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
    }
    
    let emailAlert = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        $0.textColor = UIColor.rgb(red: 255, green: 108, blue: 0)
    }
    
    let pwLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let pwTextField = CustomTextField(image: UIImage(named: "password")!, text: "영문자와 숫자 포함 8자 이상 입력", state: .login).then {
        $0.backgroundColor = UIColor.rgb(red: 243, green: 243, blue: 243)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.isSecureTextEntry = true
    }
    
    let pwAlert = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        $0.textColor = UIColor.rgb(red: 255, green: 108, blue: 0)
    }
    
    let logInBt = UIButton(type: .custom).then {
        $0.setTitle("로그인하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor.rgb(red: 177, green: 177, blue: 177)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 128, bottom: 14, right: 127)
        $0.isEnabled = false
    }
    
    let loginAlert = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        $0.textColor = UIColor.rgb(red: 255, green: 108, blue: 0)
    }
    
    let findEmailBt = UIButton(type: .custom).then {
        $0.setTitle("이메일 찾기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.setTitleColor(UIColor.rgb(red: 147, green: 147, blue: 147), for: .normal)
        $0.titleEdgeInsets.top = 9
        $0.titleEdgeInsets.bottom = 10
        $0.titleEdgeInsets.left = 16
        $0.titleEdgeInsets.right = 20
    }
    
    let findPwBt = UIButton(type: .custom).then {
        $0.setTitle("비밀번호 재설정", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.setTitleColor(UIColor.rgb(red: 147, green: 147, blue: 147), for: .normal)
        $0.titleEdgeInsets.top = 9
        $0.titleEdgeInsets.bottom = 8
        $0.titleEdgeInsets.left = 20
        $0.titleEdgeInsets.right = 5
    }
    
    let separator = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 224, green: 224, blue: 224)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
        
        safeArea.addSubview(emailAlert)
        emailAlert.snp.makeConstraints {
            $0.top.equalTo(self.emailTextField.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(27)
        }
        
        safeArea.addSubview(pwLabel)
        pwLabel.snp.makeConstraints {
            $0.top.equalTo(emailAlert.snp.bottom).offset(17)
            $0.leading.equalToSuperview().offset(24)
        }
        
        safeArea.addSubview(pwTextField)
        pwTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.top.equalTo(pwLabel.snp.bottom).offset(9)
        }
        
        safeArea.addSubview(pwAlert)
        pwAlert.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(27)
        }
        
        safeArea.addSubview(logInBt)
        logInBt.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(35)
            $0.centerX.equalToSuperview()
        }
        
        let findStack = UIStackView(arrangedSubviews: [findEmailBt, findPwBt]).then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 0
        }
        
        safeArea.addSubview(findStack)
        findStack.snp.makeConstraints {
            $0.top.equalTo(logInBt.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(56)
            $0.trailing.equalToSuperview().offset(-57)
        }
        
        safeArea.addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.equalTo(logInBt.snp.bottom).offset(21)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(findStack.snp.height).multipliedBy(0.6)
            $0.width.equalTo(2)
        }
        
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        backBt.rx.tap.subscribe(onNext: {
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent([.editingDidEnd])
            .map { self.emailTextField.text ?? "" }
            .bind(to: self.vm.input.emailObserver)
            .disposed(by: disposeBag)
        
        pwTextField.rx.controlEvent([.editingDidEnd])
            .map { self.pwTextField.text ?? "" }
            .bind(to: self.vm.input.pwObserver)
            .disposed(by: disposeBag)
        
        logInBt.rx.tap
            .bind(to: self.vm.input.loginObserver)
            .disposed(by: disposeBag)
        
        findEmailBt.rx.tap
            .subscribe(onNext: {
                let vc = FindEmailViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        findPwBt.rx.tap
            .subscribe(onNext: {
                let vc = FindPasswordViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
    }
    
    func bindOutput() {
        vm.output.emailValid.drive(onNext: {valid in
            if valid {
                self.emailAlert.text = ""
                self.emailTextField.setRight()
            } else {
                self.emailAlert.text = "이메일 형식이 올바르지 않습니다."
                self.emailTextField.setErrorRight()
            }
        }).disposed(by: disposeBag)
        
        vm.output.pwValid.drive(onNext: {valid in
            if valid {
                self.pwAlert.text = ""
                self.pwTextField.setRight()
            } else {
                self.pwAlert.text = "영문자와 숫자 포함 8자 이상 입력해주세요."
                self.pwTextField.setErrorRight()
            }
        }).disposed(by: disposeBag)
        
        vm.output.loginValid.drive(onNext: {valid in
            if valid {
                self.logInBt.isEnabled = true
                self.logInBt.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
            } else {
                self.logInBt.isEnabled = false
                self.logInBt.backgroundColor = UIColor.rgb(red: 177, green: 177, blue: 177)
            }
        }).disposed(by: disposeBag)
        
        
        vm.output.doLogin.asDriver(onErrorJustReturn: ())
            .drive(onNext: {
            let viewController = LoadingViewController()
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }).disposed(by: disposeBag)
        
        vm.output.doError.asSignal()
            .emit(onNext: { error in
            let alertController = UIAlertController(title: "에러", message: error.msg, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alertController, animated: true)
        }).disposed(by: disposeBag)
        
    }
}
