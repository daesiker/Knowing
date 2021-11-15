//
//  SignUpViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/15.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    let vm = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    let scrollView:UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
        sv.isScrollEnabled = true
        sv.layoutIfNeeded()
        return sv
    }()
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let welcomeLabel = UILabel().then {
        $0.text = "환영합니다!"
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
    }
    
    let titleLabel = UILabel().then {
        $0.attributedText = NSAttributedString(string: "한페이지로\n끝내는 회원가입").withLineSpacing(6)
        $0.font = UIFont(name: "GodoM", size: 26)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.numberOfLines = 2
        
    }
    
    let nameLabel = UILabel().then {
        $0.text = "이름"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let nameTextField = CustomTextField(image: UIImage(named: "person")!, text: "이름 입력").then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        
    }
    
    let nameAlertLabel = UILabel().then {
        $0.text = ""
        $0.textColor = UIColor.rgb(red: 255, green: 108, blue: 0)
        $0.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 11)
    }
    
    let emailLabel = UILabel().then {
        $0.text = "이메일"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let emailTextField = CustomTextField(image: UIImage(named: "email")!, text: "이메일 주소 입력").then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
    }
    
    let emailAlertLabel = UILabel().then {
        $0.text = ""
        $0.textColor = UIColor.rgb(red: 255, green: 108, blue: 0)
        $0.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 11)
    }
    
    let pwLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let pwTextField = CustomTextField(image: UIImage(named: "password")!, text: "영문자와 숫자 포함 8자 이상 입력").then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.isSecureTextEntry = true
    }
    
    let pwAlertLabel = UILabel().then {
        $0.text = ""
        $0.textColor = UIColor.rgb(red: 255, green: 108, blue: 0)
        $0.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 11)
    }
    
    let pwConfirmLabel = UILabel().then {
        $0.text = "비밀번호 확인"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let pwConfirmTextField = CustomTextField(image: UIImage(named: "password")!, text: "다시 한번 입력").then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.isSecureTextEntry = true
    }
    
    let pwConfirmAlertLabel = UILabel().then {
        $0.text = ""
        $0.textColor = UIColor.rgb(red: 255, green: 108, blue: 0)
        $0.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 11)
    }
    
    let phoneLb = UILabel().then {
        $0.text = "전화번호"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let phoneTextField = CustomTextField(image: UIImage(named: "phone")!, text: "'-'없이 입력").then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        $0.keyboardType = .numberPad
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
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 195, green: 195, blue: 195)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 134, bottom: 13, right: 131)
        $0.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
        //keyboardNotification()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.scrollView.endEditing(true)
    }
    
    func keyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
}

extension SignUpViewController {
    
    func setUI() {
        view.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
        scrollView.delegate = self
        safeArea.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 950)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(backBt.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(25)
        }
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(26)
        }
        
        scrollView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(33)
            $0.leading.equalToSuperview().offset(25)
        }
        
        scrollView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeArea.snp.leading).offset(26)
            $0.trailing.equalTo(self.safeArea.snp.trailing).offset(-25)
        }
        
        scrollView.addSubview(nameAlertLabel)
        nameAlertLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(5)
            $0.leading.equalTo(self.safeArea.snp.leading).offset(25)
        }
        
        scrollView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(25)
        }
        scrollView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(emailLabel.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeArea.snp.leading).offset(26)
            $0.trailing.equalTo(self.safeArea.snp.trailing).offset(-25)
        }
        scrollView.addSubview(emailAlertLabel)
        emailAlertLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(5)
            $0.leading.equalTo(self.safeArea.snp.leading).offset(25)
        }
        
        scrollView.addSubview(pwLabel)
        pwLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(25)
        }
        scrollView.addSubview(pwTextField)
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(pwLabel.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeArea.snp.leading).offset(26)
            $0.trailing.equalTo(self.safeArea.snp.trailing).offset(-25)
        }
        scrollView.addSubview(pwAlertLabel)
        pwAlertLabel.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(5)
            $0.leading.equalTo(self.safeArea.snp.leading).offset(25)
        }
        
        scrollView.addSubview(pwConfirmLabel)
        pwConfirmLabel.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(25)
        }
        
        scrollView.addSubview(pwConfirmTextField)
        pwConfirmTextField.snp.makeConstraints {
            $0.top.equalTo(pwConfirmLabel.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeArea.snp.leading).offset(26)
            $0.trailing.equalTo(self.safeArea.snp.trailing).offset(-25)
        }
        
        scrollView.addSubview(pwConfirmAlertLabel)
        pwConfirmAlertLabel.snp.makeConstraints {
            $0.top.equalTo(pwConfirmTextField.snp.bottom).offset(5)
            $0.leading.equalTo(self.safeArea.snp.leading).offset(25)
        }
        
        scrollView.addSubview(phoneLb)
        phoneLb.snp.makeConstraints {
            $0.top.equalTo(pwConfirmTextField.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(25)
        }
        
        scrollView.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints {
            $0.top.equalTo(phoneLb.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeArea.snp.leading).offset(26)
            $0.trailing.equalTo(self.safeArea.snp.trailing).offset(-25)
        }
        
        scrollView.addSubview(genderLabel)
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(phoneTextField.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(25)
        }
        
        let genderStackView = UIStackView(arrangedSubviews: [maleBt, femaleBt]).then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 28
        }
        
        scrollView.addSubview(genderStackView)
        genderStackView.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(8)
            $0.leading.equalTo(safeArea.snp.leading).offset(26)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-25)
            
        }
        
        scrollView.addSubview(birthLabel)
        birthLabel.snp.makeConstraints {
            $0.top.equalTo(genderStackView.snp.bottom).offset(28)
            $0.leading.equalTo(safeArea.snp.leading).offset(25)
        }
        
        scrollView.addSubview(birthTextField)
        birthTextField.snp.makeConstraints {
            $0.top.equalTo(birthLabel.snp.bottom).offset(8)
            $0.leading.equalTo(safeArea.snp.leading).offset(26)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-25)
        }
        
        scrollView.addSubview(signInBt)
        signInBt.snp.makeConstraints {
            $0.top.equalTo(birthTextField.snp.bottom).offset(30)
            $0.leading.equalTo(safeArea.snp.leading).offset(26)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-25)
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
        
        emailTextField.rx.controlEvent([.editingDidEnd])
            .map { self.emailTextField.text ?? "" }
            .bind(to: vm.input.emailObserver)
            .disposed(by: disposeBag)
        
        pwTextField.rx.controlEvent([.editingDidEnd])
            .map { self.pwTextField.text ?? "" }
            .bind(to: vm.input.pwObserver)
            .disposed(by: disposeBag)
        
        pwConfirmTextField.rx.controlEvent([.editingDidEnd])
            .map { self.pwConfirmTextField.text ?? "" }
            .bind(to: vm.input.pwConfirmObserver)
            .disposed(by: disposeBag)
        
        maleBt.rx.tap
            .map { Gender.male }
            .bind(to: vm.input.genderObserver)
            .disposed(by: disposeBag)
        
        femaleBt.rx.tap
            .map { Gender.female }
            .bind(to: vm.input.genderObserver)
            .disposed(by: disposeBag)
        
        birthTextField.rx.controlEvent([.editingDidEnd])
            .map { self.birthTextField.text ?? "" }
            .bind(to: vm.input.birthObserver)
            .disposed(by: disposeBag)
        
        signInBt.rx.tap.subscribe(onNext: {
            let vc = ExtraSignUpViewController()
            ExtraSignUpViewModel.instance.user = self.vm.user
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
    }
    
    func bindOutput() {
        vm.output.emailValid.drive(onNext: {valid in
            if valid {
                self.emailAlertLabel.text = ""
                self.emailTextField.setRight()
            } else {
                self.emailAlertLabel.text = "이메일 형식이 올바르지 않습니다."
                self.emailTextField.setErrorRight()
            }
        }).disposed(by: disposeBag)
        
        vm.output.pwValid.drive(onNext: {valid in
            if valid {
                self.pwAlertLabel.text = ""
                self.pwTextField.setRight()
            } else {
                self.pwAlertLabel.text = "영문자와 숫자 포함 8자 이상 입력해주세요."
                self.pwTextField.setErrorRight()
            }
        }).disposed(by: disposeBag)
        
        vm.output.pwConfirmValid.drive(onNext: { valid in
            if valid {
                self.pwConfirmAlertLabel.text = ""
                self.pwConfirmTextField.setRight()
            } else {
                self.pwConfirmAlertLabel.text = "비밀번호가 맞지 않습니다."
                self.pwConfirmTextField.setErrorRight()
            }
        }).disposed(by: disposeBag)
        
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
            print(valid)
            if valid {
                self.signInBt.isEnabled = true
                self.signInBt.backgroundColor = UIColor.rgb(red: 251, green: 136, blue: 85)
            } else {
                self.signInBt.isEnabled = false
                self.signInBt.backgroundColor = UIColor.rgb(red: 195, green: 195, blue: 195)
            }
        }).disposed(by: disposeBag)
    }
    
}

extension SignUpViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
}
