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
    
    let titleLb = UILabel().then {
        $0.text = "knowing"
        $0.textColor = UIColor.rgb(red: 249, green: 133, blue: 81)
        $0.font = UIFont(name: "GodoM", size: 20)
    }
    
    let subLb = UILabel().then {
        $0.attributedText = NSAttributedString(string: "간편한 이용을 위해\n약관에 동의해주세요").withLineSpacing(6)
        $0.font = UIFont(name: "GodoM", size: 24)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.numberOfLines = 2
    }
    
    let titleImg = UIImageView(image: UIImage(named: "agreeImg")!)
    
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
    
    let nextBt = UIButton(type: .custom).then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.titleLabel?.textColor = .white
        $0.backgroundColor = UIColor.rgb(red: 210, green: 210, blue: 210)
        $0.layer.cornerRadius = 27.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 15, left: 142, bottom: 13, right: 141)
        $0.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
}

extension AgreeTermsViewController {
    
    func setUI() {
        view.backgroundColor = .white
        
        safeArea.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(31)
            $0.leading.equalToSuperview().offset(29)
        }
        
        safeArea.addSubview(subLb)
        subLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(29)
        }
        
        safeArea.addSubview(titleImg)
        titleImg.snp.makeConstraints {
            $0.top.equalTo(subLb.snp.bottom).offset(42)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(allCbImg)
        allCbImg.snp.makeConstraints {
            $0.width.height.equalTo(47)
            $0.top.equalTo(titleImg.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)
        }
        
        safeArea.addSubview(allLb)
        allLb.snp.makeConstraints {
            $0.top.equalTo(titleImg.snp.bottom).offset(64)
            $0.leading.equalTo(allCbImg.snp.trailing).offset(2)
        }
        
        safeArea.addSubview(separator)
        separator.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(allLb.snp.bottom).offset(23)
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-31)
        }
        
        safeArea.addSubview(firstCbImg)
        firstCbImg.snp.makeConstraints {
            $0.width.height.equalTo(47)
            $0.top.equalTo(separator.snp.bottom).offset(9)
            $0.leading.equalToSuperview().offset(18)
        }
        
        safeArea.addSubview(firstLb)
        firstLb.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(23)
            $0.leading.equalTo(firstCbImg.snp.trailing).offset(2)
        }
        
        safeArea.addSubview(firstBt)
        firstBt.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(separator.snp.bottom).offset(11)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        safeArea.addSubview(secondCbImg)
        secondCbImg.snp.makeConstraints {
            $0.width.height.equalTo(47)
            $0.top.equalTo(firstCbImg.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(18)
        }
        
        safeArea.addSubview(secondLb)
        secondLb.snp.makeConstraints {
            $0.top.equalTo(firstLb.snp.bottom).offset(34)
            $0.leading.equalTo(secondCbImg.snp.trailing).offset(2)
        }
        
        safeArea.addSubview(secondSubLb)
        secondSubLb.snp.makeConstraints {
            $0.top.equalTo(secondLb.snp.bottom).offset(9)
            $0.leading.equalTo(secondLb.snp.leading)
        }
        
        safeArea.addSubview(secondBt)
        secondBt.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.top.equalTo(firstBt.snp.bottom).offset(9)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        safeArea.addSubview(thirdCbImg)
        thirdCbImg.snp.makeConstraints {
            $0.width.height.equalTo(47)
            $0.top.equalTo(secondCbImg.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(18)
        }
        
        safeArea.addSubview(thirdLb)
        thirdLb.snp.makeConstraints {
            $0.top.equalTo(secondSubLb.snp.bottom).offset(26)
            $0.leading.equalTo(thirdCbImg.snp.trailing).offset(2)
        }
        
        safeArea.addSubview(nextBt)
        nextBt.snp.makeConstraints {
            $0.top.equalTo(thirdLb.snp.bottom).offset(47)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
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
            .subscribe(onNext: {
                let vc = SignUpViewController()
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
        
    }
    
}
