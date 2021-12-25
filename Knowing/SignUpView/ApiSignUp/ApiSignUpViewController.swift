//
//  ApiSignUpViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/15.
//

import UIKit
import RxCocoa
import RxSwift


class ApiSignUpViewController: UIViewController {
    
    let vm = ApiSignUpViewModel()
    let disposeBag = DisposeBag()
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let welcomeLabel = UILabel().then {
        $0.text = "환영합니다!"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
    }
    
    let titleLabel = UILabel().then {
        $0.attributedText = NSAttributedString(string: "이용자님,\n뭐라고 불러드릴까요?").withLineSpacing(6)
        $0.font = UIFont(name: "GodoM", size: 26)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.numberOfLines = 2
    }
    
    let nameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let nameTextField = CustomTextField(image: UIImage(named: "person")!, text: "닉네임 입력").then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
    }
    
    let genderLabel = UILabel().then {
        $0.text = "성별"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let maleBt = UIButton(type: .custom).then {
        $0.backgroundColor = .white
        $0.setTitle("남성", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.setTitleColor(UIColor.rgb(red: 55, green: 57, blue: 61), for: .normal)
        $0.layer.cornerRadius = 20.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 16, left: 61, bottom: 15, right: 61)
    }
    
    let femaleBt = UIButton(type: .custom).then {
        $0.setTitle("여성", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.setTitleColor(UIColor.rgb(red: 55, green: 57, blue: 61), for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 16, left: 61, bottom: 15, right: 61)
    }
    
    let birthLabel = UILabel().then {
        $0.text = "생년월일"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let birthTextField = CustomTextField(image: UIImage(named: "birth")!, text: "2000 / 06 / 15").then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.setDatePicker(target: self)
    }
    
    let signInBt = UIButton(type: .custom).then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 195, green: 195, blue: 195)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 149, bottom: 13, right: 148)
        $0.isEnabled = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lightMode()
        setUI()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

extension ApiSignUpViewController {
    
    func setUI() {
        view.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
        
        
        safeArea.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(20)
        }
        
        safeArea.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(backBt.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(25)
        }
        
        safeArea.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(26)
        }
        
        safeArea.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(48)
            $0.leading.equalToSuperview().offset(25)
        }
        
        safeArea.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        safeArea.addSubview(genderLabel)
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(25)
        }
        
        let genderStackView = UIStackView(arrangedSubviews: [maleBt, femaleBt]).then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 28
        }
        
        safeArea.addSubview(genderStackView)
        genderStackView.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        safeArea.addSubview(birthLabel)
        birthLabel.snp.makeConstraints {
            $0.top.equalTo(genderStackView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(25)
        }
        
        safeArea.addSubview(birthTextField)
        birthTextField.snp.makeConstraints {
            $0.top.equalTo(birthLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        safeArea.addSubview(signInBt)
        signInBt.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-22)
            $0.centerX.equalToSuperview()
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
            .bind(to: vm.input.nameObserver)
            .disposed(by: disposeBag)
        
        maleBt.rx.tap
            .map { Gender.male }
            .bind(to: vm.input.genderObserver)
            .disposed(by: disposeBag)
        
        femaleBt.rx.tap
            .map { Gender.female}
            .bind(to: vm.input.genderObserver)
            .disposed(by: disposeBag)
        
        birthTextField.rx.controlEvent([.editingDidEnd])
            .map { self.birthTextField.text ?? "" }
            .bind(to: vm.input.birthObserver)
            .disposed(by: disposeBag)
        
        signInBt.rx.tap
            .bind(to: vm.input.signUpObserver)
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        vm.output.genderValid.drive(onNext: {valid in
            switch valid{
            case .male:
                self.maleBt.setTitleColor(.white, for: .normal)
                self.maleBt.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                self.femaleBt.setTitleColor(UIColor.rgb(red: 55, green: 57, blue: 61), for: .normal)
                self.femaleBt.backgroundColor = .white
            case .female:
                self.femaleBt.setTitleColor(.white, for: .normal)
                self.femaleBt.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
                self.maleBt.setTitleColor(UIColor.rgb(red: 55, green: 57, blue: 61), for: .normal)
                self.maleBt.backgroundColor = .white
            case .notSelected:
                break
            }
        }).disposed(by: disposeBag)
        
        vm.output.buttonValid.drive(onNext: {valid in
            if valid {
                self.signInBt.isEnabled = true
                self.signInBt.backgroundColor = UIColor.rgb(red: 251, green: 136, blue: 85)
            } else {
                self.signInBt.isEnabled = false
                self.signInBt.backgroundColor = UIColor.rgb(red: 195, green: 195, blue: 195)
            }
        }).disposed(by: disposeBag)
        
        vm.output.signUpValue.subscribe(onNext: {value in
            let vc = ExtraSignUpViewController()
            let vm = ExtraSignUpViewModel.instance
            vm.user = value
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }).disposed(by: disposeBag)
        
    }
    
}
