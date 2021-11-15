//
//  FindIDViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/10.
//

import UIKit
import RxCocoa
import RxSwift
import Foundation

class FindEmailViewController: UIViewController {

    let disposeBag = DisposeBag()
    let vm = FindEmailViewModel()
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let titleLb = UILabel().then {
        $0.text = "이메일 찾기"
        $0.font = UIFont(name: "GodoM", size: 24)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
    }
    
    let nameLb = UILabel().then {
        $0.text = "이름"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let nameTextField = CustomTextField(image: UIImage(named: "person")!, text: "이름 입력", isLogin: true).then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.keyboardType = .namePhonePad
    }
    
    let phoneLb = UILabel().then {
        $0.text = "전화번호"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let phoneTextField = CustomTextField(image: UIImage(named: "phone")!, text: "'-'없이 입력", isLogin: true).then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.keyboardType = .numberPad
    }
    
    let confirmBt = UIButton(type: .custom).then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 210, green: 210, blue: 210)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 16, left: 148, bottom: 15, right: 148)
        $0.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension FindEmailViewController {
    func setUI() {
        view.backgroundColor = .white
        
        safeArea.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(19)
            $0.top.equalToSuperview().offset(30)
        }
        
        safeArea.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(nameLb)
        nameLb.snp.makeConstraints {
            $0.top.equalTo(backBt.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(25)
        }
        
        safeArea.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLb.snp.bottom).offset(9)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        safeArea.addSubview(phoneLb)
        phoneLb.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(25)
        }
        
        safeArea.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints {
            $0.top.equalTo(phoneLb.snp.bottom).offset(9)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        safeArea.addSubview(confirmBt)
        confirmBt.snp.makeConstraints {
            $0.top.equalTo(phoneTextField.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
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
        
        nameTextField.rx.controlEvent([.editingDidEnd])
            .map { self.nameTextField.text ?? "" }
            .bind(to: self.vm.input.nameObserver)
            .disposed(by: disposeBag)
        
        phoneTextField.rx.controlEvent([.editingDidEnd])
            .map { self.phoneTextField.text ?? "" }
            .bind(to: self.vm.input.phoneObserver)
            .disposed(by: disposeBag)
        
        confirmBt.rx.tap
            .bind(to: self.vm.input.buttonObserver)
            .disposed(by: disposeBag)
        
        confirmBt.rx.tap
            .subscribe(onNext: {
                let vc = ConfirmEmailViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
    }
    
    func bindOutput() {
        
        vm.output.btValid.drive(onNext: {value in
            if value {
                self.confirmBt.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
                self.confirmBt.isEnabled = true
            } else {
                self.confirmBt.backgroundColor = UIColor.rgb(red: 210, green: 210, blue: 210)
                self.confirmBt.isEnabled = false
            }
        }).disposed(by: disposeBag)
        
        
        
    }
}
