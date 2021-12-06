//
//  APModifyUserViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/30.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import Firebase

class APIModifyUserViewController: UIViewController {
    
    let vm:APIModifyUserViewModel
    let disposeBag = DisposeBag()
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let titleLb = UILabel().then {
        $0.text = "회원정보 수정하기"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "GodoM", size: 26)
    }
    
    let accountLabel = UILabel().then {
        $0.text = "계정"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    lazy var accountView:AccountLabel = {
        let view = AccountLabel(vm.user.provider)
       return view
    }()
    
    let nameLabel = UILabel().then {
        $0.text = "이름"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 100, green: 98, blue: 94)
    }
    
    let nameTextField = CustomTextField(image: UIImage(named: "person")!, text: "이름 입력").then {
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
    
    let modifyBt = UIButton(type: .custom).then {
        $0.setTitle("수정하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 251, green: 136, blue: 85)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 134, bottom: 13, right: 134)
        $0.isEnabled = true
    }
    
    init(vm: APIModifyUserViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue()
        setUI()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setUI() {
        view.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
        
        safeArea.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(20)
        }
        
        safeArea.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalTo(backBt.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(25)
        }
        
        safeArea.addSubview(accountLabel)
        accountLabel.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(48)
            $0.leading.equalToSuperview().offset(25)
        }
        
        safeArea.addSubview(accountView)
        accountView.snp.makeConstraints {
            $0.top.equalTo(accountLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(42)
        }
        
        safeArea.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(accountView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(25)
        }
        
        safeArea.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(42)
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
        
        safeArea.addSubview(modifyBt)
        modifyBt.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-22)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        
        backBt.rx.tap
            .subscribe(onNext: {
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
        
        modifyBt.rx.tap
            .bind(to: vm.input.modifyObserver)
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
                self.modifyBt.isEnabled = true
                self.modifyBt.backgroundColor = UIColor.rgb(red: 251, green: 136, blue: 85)
            } else {
                self.modifyBt.isEnabled = false
                self.modifyBt.backgroundColor = UIColor.rgb(red: 195, green: 195, blue: 195)
            }
        }).disposed(by: disposeBag)
        
        vm.output.modifyValue.asSignal()
            .emit(onNext: { value in
                let vc = LoadingViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
        }).disposed(by: disposeBag)
        
        vm.output.errorValue.asSignal()
            .emit(onNext: { error in
            let alert = UIAlertController(title: "에러", message: "네트워크 상태를 확인해 주세요.", preferredStyle: .alert)
            self.present(alert, animated: false)
        }).disposed(by: disposeBag)
        
    }
    
    func setValue() {
        
        nameTextField.text = vm.user.name
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
    
}

class APIModifyUserViewModel {
    
    let disposeBag = DisposeBag()
    var user:User
    
    let input = Input()
    var output = Output()
    
    struct Input {
        let nameObserver = PublishRelay<String>()
        let genderObserver = PublishRelay<Gender>()
        let birthObserver = PublishRelay<String>()
        let modifyObserver = PublishRelay<Void>()
    }
    
    struct Output {
        var genderValid:Driver<Gender> = PublishRelay<Gender>().asDriver(onErrorJustReturn: .notSelected)
        var buttonValid:Driver<Bool> = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var modifyValue = PublishRelay<User>()
        var errorValue = PublishRelay<Error>()
    }
    
    init(_ user: User) {
        self.user = user
        
        input.nameObserver.subscribe(onNext: {valid in
            self.user.name = valid
            self.output.buttonValid = Observable<Bool>.just(true).asDriver(onErrorJustReturn: false)
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
            self.output.buttonValid = Observable<Bool>.just(true).asDriver(onErrorJustReturn: false)
        }).disposed(by: disposeBag)
        
        input.birthObserver.subscribe(onNext: {valid in
            let age = Int(valid.replacingOccurrences(of: " / ", with: "")) ?? 0
            self.user.birth = age
            self.output.buttonValid = Observable<Bool>.just(true).asDriver(onErrorJustReturn: false)
        }).disposed(by: disposeBag)
        
        input.modifyObserver
            .flatMap(modifyUser)
            .subscribe({ result in
                switch result {
                case .completed:
                    break
                case .error(let error):
                    self.output.errorValue.accept(error)
                case .next(let user):
                    self.output.modifyValue.accept(user)
                }
            })
            .disposed(by: disposeBag)
        
        
        output.genderValid = input.genderObserver.asDriver(onErrorJustReturn: .notSelected)
        
    }
    
    func modifyUser() -> Observable<User> {
        
        return Observable<User>.create { observer in
            
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
                        observer.onNext(self.user)
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
        
    }
    
    
}

class AccountLabel: UIView {
    
    let logoView = UIImageView()
    
    let titleLb = UILabel().then {
        $0.textColor = UIColor.rgb(red: 55, green: 57, blue: 61)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        layer.cornerRadius = 20.0
        layer.borderWidth = 1.0
        layer.borderColor = CGColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        addSubview(logoView)
        logoView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(logoView.snp.trailing).offset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ provider: String) {
        self.init()
        if provider == "naver" {
            logoView.image = UIImage(named: "logoNaverSmall")
            titleLb.text = "네이버로 로그인한 계정"
        } else if provider == "kakao" {
            logoView.image = UIImage(named: "logoKakaoSmall")
            titleLb.text = "카카오로 로그인한 계정"
        } else if provider == "apple" {
            logoView.image = UIImage(named: "logoAppleSmall")
            titleLb.text = "애플로 로그인한 계정"
        } else {
            logoView.image = UIImage(named: "logoGoogleSmall")
            titleLb.text = "구글로 로그인한 계정"
        }
    }
    
}
