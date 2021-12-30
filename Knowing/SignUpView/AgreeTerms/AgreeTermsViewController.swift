//
//  AgreeTermsViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/14.
//

import UIKit
import RxSwift
import RxCocoa

class AgreeTermsViewController: UIViewController {

    let disposeBag = DisposeBag()
    let vm = AgreeTermsViewModel()
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    lazy var scrollView = UIScrollView(frame: .zero).then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
    }
    
    let titleLb = UIImageView(image: UIImage(named: "textLogo")!)
    
    let subLb = UILabel().then {
        $0.attributedText = NSAttributedString(string: "간편한 이용을 위해\n약관에 동의해주세요").withLineSpacing(6)
        $0.font = UIFont(name: "GodoM", size: 24)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.numberOfLines = 2
    }
    
    let titleImg = UIImageView(image: UIImage(named: "agreeImg")!).then {
        $0.sizeToFit()
    }
    
    let allCbImg =  UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
    }
    
    let allLb = UILabel().then {
        $0.text = "모두 동의합니다."
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    let separator = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
    }
    
    let firstCbImg =  UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
    }
    
    let firstLb = UILabel().then {
        $0.text = "이용약관 (필수)"
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
    }
    
    let firstBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "rightArrow")!, for: .normal)
    }
    
    let secondCbImg =  UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
    }
    
    let secondLb = UILabel().then {
        $0.text = "개인정보 수집 이용(필수)"
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
    }
    
    let secondSubLb = UILabel().then {
        $0.text = "맞춤 정보 제공을 위해서 필요해요"
        $0.textColor = UIColor.rgb(red: 184, green: 184, blue: 184)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
    }
    
    let secondBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "rightArrow")!, for: .normal)
    }
    
    let thirdCbImg = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
    }
    let thirdLb = UILabel().then {
        $0.text = "복지 정보 앱 푸시 알림 수신 동의 (선택)"
        $0.textColor = UIColor.rgb(red: 91, green: 91, blue: 91)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
    }
    
    let thirdDetailLb = UILabel().then {
        $0.text = "비동의 시, 중요한 맞춤 복지 알림을 놓칠 수도 있어요!"
        $0.textColor = UIColor.rgb(red: 251, green: 136, blue: 85)
        $0.font =  UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
    }
    
    let nextBt = UIButton(type: .custom).then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 210, green: 210, blue: 210)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 142, bottom: 13, right: 141)
        $0.isEnabled = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lightMode()
        setUI()
        bind()
    }
    
}

extension AgreeTermsViewController {
    
    func setUI() {
        view.backgroundColor = .white
        
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
        
        scrollView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalTo(backBt.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(29)
            $0.height.equalTo(25)
        }
        
        scrollView.addSubview(subLb)
        subLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(29)
        }
        
        scrollView.addSubview(titleImg)
        titleImg.snp.makeConstraints {
            $0.top.equalTo(subLb.snp.bottom).offset(42)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(185)
            $0.height.equalTo(150)
        }
        
        scrollView.addSubview(allCbImg)
        allCbImg.snp.makeConstraints {
            $0.width.height.equalTo(47)
            $0.top.equalTo(titleImg.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)
        }
        
        scrollView.addSubview(allLb)
        allLb.snp.makeConstraints {
            $0.top.equalTo(titleImg.snp.bottom).offset(64)
            $0.leading.equalTo(allCbImg.snp.trailing).offset(2)
        }
        
        scrollView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(allLb.snp.bottom).offset(23)
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-31)
        }
        
        scrollView.addSubview(firstCbImg)
        firstCbImg.snp.makeConstraints {
            $0.width.height.equalTo(47)
            $0.top.equalTo(separator.snp.bottom).offset(9)
            $0.leading.equalToSuperview().offset(18)
        }
        
        scrollView.addSubview(firstLb)
        firstLb.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(23)
            $0.leading.equalTo(firstCbImg.snp.trailing).offset(2)
        }
        
        scrollView.addSubview(firstBt)
        firstBt.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(separator.snp.bottom).offset(11)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-15)
        }
        
        scrollView.addSubview(secondCbImg)
        secondCbImg.snp.makeConstraints {
            $0.width.height.equalTo(47)
            $0.top.equalTo(firstCbImg.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(18)
        }
        
        scrollView.addSubview(secondLb)
        secondLb.snp.makeConstraints {
            $0.top.equalTo(firstLb.snp.bottom).offset(34)
            $0.leading.equalTo(secondCbImg.snp.trailing).offset(2)
        }
        
        scrollView.addSubview(secondSubLb)
        secondSubLb.snp.makeConstraints {
            $0.top.equalTo(secondLb.snp.bottom).offset(9)
            $0.leading.equalTo(secondLb.snp.leading)
        }
        
        scrollView.addSubview(secondBt)
        secondBt.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(firstBt.snp.bottom).offset(9)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-15)
        }
        
        scrollView.addSubview(thirdCbImg)
        thirdCbImg.snp.makeConstraints {
            $0.width.height.equalTo(47)
            $0.top.equalTo(secondCbImg.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(18)
        }
        
        scrollView.addSubview(thirdLb)
        thirdLb.snp.makeConstraints {
            $0.top.equalTo(secondSubLb.snp.bottom).offset(26)
            $0.leading.equalTo(thirdCbImg.snp.trailing).offset(2)
        }
        
        scrollView.addSubview(thirdDetailLb)
        thirdDetailLb.snp.makeConstraints {
            $0.leading.equalTo(thirdLb)
            $0.top.equalTo(thirdLb.snp.bottom).offset(9)
        }
        
        scrollView.addSubview(nextBt)
        nextBt.snp.makeConstraints {
            $0.top.equalTo(thirdDetailLb.snp.bottom).offset(33)
            $0.leading.equalToSuperview().offset(31)
            $0.height.equalTo(47)
        }
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        backBt.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        allCbImg.rx.tap
            .bind(to: vm.input.allObserver)
            .disposed(by: disposeBag)
        
        firstCbImg.rx.tap
            .bind(to: vm.input.firstObserver)
            .disposed(by: disposeBag)
        
        secondCbImg.rx.tap
            .bind(to: vm.input.secondObserver)
            .disposed(by: disposeBag)
        
        thirdCbImg.rx.tap
            .bind(to: vm.input.thirdObserver)
            .disposed(by: disposeBag)
        
        nextBt.rx.tap
            .bind(to: vm.input.nextBtObserver)
            .disposed(by: disposeBag)
        
        firstBt.rx.tap
            .subscribe(onNext: {
                let vc = PersonnalInfoViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
        secondBt.rx.tap
            .subscribe(onNext: {
                let vc = PersonnalInfoViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
    }
    
    func bindOutput() {
        vm.output.allValid.drive(onNext: { valid in
            if valid[0] {
                self.allCbImg.setImage(UIImage(named: "checkbox_selected")!, for: .normal)
                self.firstCbImg.setImage(UIImage(named: "checkbox_selected")!, for: .normal)
                self.secondCbImg.setImage(UIImage(named: "checkbox_selected")!, for: .normal)
                self.thirdCbImg.setImage(UIImage(named: "checkbox_selected")!, for: .normal)
            } else {
                self.allCbImg.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
                self.firstCbImg.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
                self.secondCbImg.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
                self.thirdCbImg.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
            }
        }).disposed(by: disposeBag)
        
        vm.output.firstValid.drive(onNext: { valid in
            
            if valid[0] {
                self.allCbImg.setImage(UIImage(named: "checkbox_selected")!, for: .normal)
            } else {
                self.allCbImg.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
            }
            
            if valid[1] {
                self.firstCbImg.setImage(UIImage(named: "checkbox_selected")!, for: .normal)
            } else {
                self.firstCbImg.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
            }
            
        }).disposed(by: disposeBag)
        
        vm.output.secondValid.drive(onNext: { valid in
            
            if valid[0] {
                self.allCbImg.setImage(UIImage(named: "checkbox_selected")!, for: .normal)
            } else {
                self.allCbImg.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
            }
            
            if valid[2] {
                self.secondCbImg.setImage(UIImage(named: "checkbox_selected")!, for: .normal)
            } else {
                self.secondCbImg.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
            }
            
        }).disposed(by: disposeBag)
        
        vm.output.thirdValid.drive(onNext: { valid in
            if valid[0] {
                self.allCbImg.setImage(UIImage(named: "checkbox_selected")!, for: .normal)
            } else {
                self.allCbImg.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
            }
            if valid[3] {
                self.thirdCbImg.setImage(UIImage(named: "checkbox_selected")!, for: .normal)
            } else {
                self.thirdCbImg.setImage(UIImage(named: "checkbox_unselected")!, for: .normal)
            }
            
        }).disposed(by: disposeBag)
        
        vm.output.nextBtValid.drive(onNext: {valid in
            if valid {
                self.nextBt.isEnabled = true
                self.nextBt.backgroundColor = UIColor.rgb(red: 255, green: 136, blue: 84)
            } else {
                self.nextBt.isEnabled = false
                self.nextBt.backgroundColor = UIColor.rgb(red: 210, green: 210, blue: 210)
            }
        }).disposed(by: disposeBag)
        
        vm.output.goToSignUp.asSignal()
            .emit(onNext: { user in
            if user.provider == "default" {
                let vc = SignUpViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.vm.user = user
                self.present(vc, animated: true)
            } else {
                let vc = ApiSignUpViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.vm.user = user
                self.present(vc, animated: true)
            }
        }).disposed(by: disposeBag)
        
        
        vm.output.errorRelay.asSignal()
            .emit(onNext: { _ in
                let alertController = UIAlertController(title: "에러", message: "인터넷 연결 상태를 확인해주세요.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alertController, animated: true)
            }).disposed(by: disposeBag)
        
    }
    
    

    
}
