//
//  DefaultModifyUserViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/30.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import SwiftyJSON
import Firebase

class DefaultModifyUserViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let vm:DefaultModifyUserViewModel
    
    lazy var scrollView = UIScrollView(frame: .zero).then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
    }
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "회원정보 수정하기"
        $0.font = UIFont(name: "GodoM", size: 26)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
    }
    
    let nameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let nameTextField = CustomTextField(image: UIImage(named: "person")!, text: "닉네임 입력").then {
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
    
    let withDrawBt = WithdrawalButton()
    
    let modifyBt = UIButton(type: .custom).then {
        $0.setTitle("수정하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 134, bottom: 13, right: 131)
        $0.isEnabled = true
    }
    
    init(vm: DefaultModifyUserViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lightMode()
        setValue()
        setUI()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setValue() {
        nameTextField.text = vm.user.name
        emailTextField.text = vm.user.email
        phoneTextField.text = vm.user.phNum
        
        if vm.user.gender == "남성" {
            maleBt.setTitleColor(.white, for: .normal)
            maleBt.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
        } else {
            self.femaleBt.setTitleColor(.white, for: .normal)
            self.femaleBt.backgroundColor = UIColor.rgb(red: 255, green: 147, blue: 81)
        }
        
        var age = String(vm.user.birth)
        
        age.insert(contentsOf: " / ", at: age.index(age.startIndex, offsetBy: 4))
        age.insert(contentsOf: " / ", at: age.index(age.endIndex, offsetBy: -2))
        
        birthTextField.text = age
    }
    
    func setUI() {
        view.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 734)
        safeArea.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        
        scrollView.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backBt.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(25)
        }
        
        scrollView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(48)
            $0.leading.equalToSuperview().offset(25)
        }
        
        scrollView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeArea.snp.leading).offset(25)
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
            $0.leading.equalTo(self.safeArea.snp.leading).offset(25)
            $0.trailing.equalTo(self.safeArea.snp.trailing).offset(-25)
        }
        
        scrollView.addSubview(emailAlertLabel)
        emailAlertLabel.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(5)
            $0.leading.equalTo(self.safeArea.snp.leading).offset(25)
        }
        
        scrollView.addSubview(phoneLb)
        phoneLb.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(25)
        }
        
        scrollView.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints {
            $0.top.equalTo(phoneLb.snp.bottom).offset(8)
            $0.leading.equalTo(self.safeArea.snp.leading).offset(25)
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
            $0.leading.equalTo(safeArea.snp.leading).offset(25)
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
            $0.leading.equalTo(safeArea.snp.leading).offset(25)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-25)
        }
        
        scrollView.addSubview(withDrawBt)
        withDrawBt.snp.makeConstraints {
            $0.top.equalTo(birthTextField.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(19)
            $0.width.equalTo(95)
            $0.height.equalTo(26)
        }
        
        scrollView.addSubview(modifyBt)
        modifyBt.snp.makeConstraints {
            $0.top.equalTo(withDrawBt.snp.bottom).offset(24)
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
        
        maleBt.rx.tap
            .map { Gender.male }
            .bind(to: vm.input.genderObserver)
            .disposed(by: disposeBag)
        
        femaleBt.rx.tap
            .map { Gender.female }
            .bind(to: vm.input.genderObserver)
            .disposed(by: disposeBag)
        
        phoneTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: vm.input.phoneObserver)
            .disposed(by: disposeBag)
        
        birthTextField.rx.controlEvent([.editingDidEnd])
            .map { self.birthTextField.text ?? "" }
            .bind(to: vm.input.birthObserver)
            .disposed(by: disposeBag)
        
        withDrawBt.rx.tap.subscribe(onNext: {
            let alertController = UIAlertController(title: "회원탈퇴", message: "정말로 탈퇴하시겠습니까?", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title:"회원탈퇴", style: .default, handler: { _ in
                self.vm.input.withDrawObserver.accept(())
            }))
            
            alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: nil))
            self.present(alertController, animated: true)
        }).disposed(by: disposeBag)
        
        modifyBt.rx.tap
            .bind(to: vm.input.modifyObserver)
            .disposed(by: disposeBag)
        
    }
    
    func bindOutput() {
        vm.output.emailValid.drive(onNext: {valid in
            switch valid {
            case .correct:
                self.emailAlertLabel.text = ""
                self.emailTextField.setRight()
            case .notAvailable:
                self.emailAlertLabel.text = "이메일 형식이 올바르지 않습니다."
                self.emailTextField.setErrorRight()
            case .alreadyExsist:
                self.emailAlertLabel.text = "이미 존재하는 이메일입니다."
                self.emailTextField.setErrorRight()
            case .serverError:
                self.emailAlertLabel.text = "인터넷 연결상태를 확인해주세요."
                self.emailTextField.setErrorRight()
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
            if valid {
                self.modifyBt.isEnabled = true
                self.modifyBt.backgroundColor = UIColor.rgb(red: 251, green: 136, blue: 85)
            } else {
                self.modifyBt.isEnabled = false
                self.modifyBt.backgroundColor = UIColor.rgb(red: 195, green: 195, blue: 195)
            }
        }).disposed(by: disposeBag)
        
        vm.output.doModify.asDriver(onErrorJustReturn: false)
            .drive(onNext: { value in
                let vc = LoadingViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
        vm.output.doWithdraw.asDriver(onErrorJustReturn: false)
            .drive(onNext: { value in
                UserDefaults.standard.setValue(nil, forKey: "provider")
                UserDefaults.standard.setValue(nil, forKey: "email")
                UserDefaults.standard.setValue(nil, forKey: "pwd")
                UserDefaults.standard.setValue(nil, forKey: "uid")
                let viewController = LoginViewController()
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
                
            }).disposed(by: disposeBag)
        
        vm.output.doError.asDriver(onErrorJustReturn: NSError.init(domain: "", code: 0, userInfo: nil))
            .drive(onNext: { value in
                
                let alertController = UIAlertController(title: "에러", message: "네트워크 상태를 확인해주세요.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alertController, animated: true)
                
            }).disposed(by: disposeBag)
        
    }
    
}

class DefaultModifyUserViewModel {
    
    var user:User
    let disposeBag = DisposeBag()
    let input = Input()
    var output = Output()
    
    struct Input {
        let nameObserver = PublishRelay<String>()
        let emailObserver = PublishRelay<String>()
        let pwObserver = PublishRelay<String>()
        let pwConfirmObserver = PublishRelay<String>()
        let phoneObserver = PublishRelay<String>()
        let genderObserver = PublishRelay<Gender>()
        let birthObserver = PublishRelay<String>()
        let modifyObserver = PublishRelay<Void>()
        let withDrawObserver = PublishRelay<Void>()
    }
    
    struct Output {
        var emailValid:Driver<EmailValid> = PublishRelay<EmailValid>().asDriver(onErrorJustReturn: .notAvailable)
        var genderValid:Driver<Gender> = PublishRelay<Gender>().asDriver(onErrorJustReturn: .notSelected)
        var buttonValid:Driver<Bool> = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var doWithdraw:PublishRelay = PublishRelay<Bool>()
        var doModify:PublishRelay = PublishRelay<Bool>()
        var doError:PublishRelay = PublishRelay<Error>()
        
    }
    
    
    init(_ user:User) {
        self.user = user
        
        input.nameObserver.subscribe(onNext: {valid in
            self.user.name = valid
        }).disposed(by: disposeBag)
        
        input.emailObserver.subscribe(onNext: {valid in
            self.user.email = valid
        }).disposed(by: disposeBag)
        
        input.phoneObserver.subscribe(onNext: {valid in
            self.user.phNum = valid
        }).disposed(by: disposeBag)
        
        input.genderObserver.subscribe(onNext: {valid in
            switch valid {
            case .male:
                self.user.gender = "남성"
            case .female:
                self.user.gender = "여성"
            case .notSelected:
                break
            }
        }).disposed(by: disposeBag)
        
        input.birthObserver.subscribe(onNext: {valid in
            let age = Int(valid.replacingOccurrences(of: " / ", with: "")) ?? 0
            self.user.birth = age
        }).disposed(by: disposeBag)
        
        input.withDrawObserver.flatMap(withDraw)
            .subscribe({ result in
                switch result {
                case .completed:
                    break
                case .error(let error):
                    self.output.doError.accept(error)
                case .next(let value):
                    MainTabViewModel.instance.clear()
                    self.output.doWithdraw.accept(value)
                }
            }).disposed(by: disposeBag)
        
        input.modifyObserver.flatMap(modifyUser).subscribe({ event in
            switch event {
            case .completed:
                break
            case .error(let error):
                self.output.doError.accept(error)
            case .next(let value):
                MainTabViewModel.instance.clear()
                self.output.doModify.accept(value)
            }
        }).disposed(by: disposeBag)
        
        output.emailValid = input.emailObserver
            .flatMap(self.emailCheck)
            .asDriver(onErrorJustReturn: .notAvailable)
        
        output.genderValid = input.genderObserver.asDriver(onErrorJustReturn: .notSelected)
        
    }
    
    func emailCheck(_ string: String) -> Observable<EmailValid> {
        
        return Observable.create { valid in
            
            if !(!string.isEmpty && string.contains(".") && string.contains("@")) {
                valid.onNext(.notAvailable)
                valid.onCompleted()
            }
            
            let url = "https://www.makeus-hyun.shop/app/users/checkemail?email=\(string)"
            AF.request(url, method: .get, encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let result = json["result"].dictionaryObject
                        
                        if let result = result?["status"] as? Bool {
                            if result {
                                valid.onNext(.correct)
                            } else {
                                valid.onNext(.alreadyExsist)
                            }
                        }
                    default:
                        valid.onNext(.serverError)
                    }
                }
            return Disposables.create()
        }
        
    }
    
    func withDraw() -> Observable<Bool> {
        
        return Observable<Bool>.create { observer in
            
            let url = "https://www.makeus-hyun.shop/app/users/userdelete"
            let uid = Auth.auth().currentUser?.uid ?? MainTabViewModel.instance.user.getUid()
            let header:HTTPHeaders = ["uid": uid,
                                      "Content-Type":"application/json"]
            
            AF.request(url, method: .delete, headers: header)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let result = json["isSuccess"].boolValue
                        observer.onNext(result)
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func modifyUser() -> Observable<Bool> {
        
        return Observable<Bool>.create { observer in
            
            let uid = Auth.auth().currentUser?.uid ?? MainTabViewModel.instance.user.getUid()
            let url = "https://www.makeus-hyun.shop/app/users/usermodify/privacy"
            let header:HTTPHeaders = ["uid": uid,
                                      "Content-Type":"application/json"]
            
            let body:[String: Any] = ["email": self.user.email,
                                      "name": self.user.name,
                                      "pwd": self.user.pwd,
                                      "phNum": self.user.phNum,
                                      "gender": self.user.gender,
                                      "birth": self.user.birth]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            AF.request(url, method: .post, headers: header)
                { urlRequest in urlRequest.httpBody = jsonData }
                .responseJSON { response in
                    switch response.result {
                    case .success(_):
                        observer.onNext(true)
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
        
    }
    
}

class WithdrawalButton: UIButton {
    
    let titleLb = UILabel().then {
        $0.text = "회원 탈퇴하기"
        $0.textColor = UIColor.rgb(red: 255, green: 142, blue: 59)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13)
    }
    
    let img = UIImageView(image: UIImage(named: "withdrawal")!)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(6)
            $0.centerY.equalToSuperview()
        }
        
        addSubview(img)
        img.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-4.5)
            $0.centerY.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
