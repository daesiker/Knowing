//
//  ModifyUserViewController.swift
//  Knowing
//
//  Created by Jun on 2021/12/14.
//

import UIKit
import RxCocoa
import RxSwift

class ModifyUserViewController: UIViewController {

    let disposeBag = DisposeBag()
    let vm = MainTabViewModel.instance
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let titleLb = UILabel().then {
        $0.text = "회원 정보 설정"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "GodoM", size: 23)
    }
    
    let defaultModifyBt = TermsButton("회원 정보 수정하기")
    
    let extraModifyBt = TermsButton("추가 정보 수정하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
        
    }
    
    func setUI() {
        view.backgroundColor = .white
        self.lightMode()
        safeArea.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(20)
        }
        
        safeArea.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(backBt.snp.bottom).offset(19)
        }
        
        safeArea.addSubview(defaultModifyBt)
        defaultModifyBt.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(48)
        }
        
        safeArea.addSubview(extraModifyBt)
        extraModifyBt.snp.makeConstraints {
            $0.top.equalTo(defaultModifyBt.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(48)
        }
        
    }
    
    func bind() {
        backBt.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        defaultModifyBt.rx.tap
            .subscribe(onNext: {
                if self.vm.user.provider == "default" {
                    let vm = DefaultModifyUserViewModel(self.vm.user)
                    let vc = DefaultModifyUserViewController(vm: vm)
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true)
                } else {
                    let vm = APIModifyUserViewModel(self.vm.user)
                    let vc = APIModifyUserViewController(vm: vm)
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc, animated: true)
                }
            }).disposed(by: disposeBag)
        
        extraModifyBt.rx.tap
            .subscribe(onNext: {
                let vm = ExtraModifyViewModel(user: self.vm.user)
                let vc = ExtraModifyViewController(vm: vm)
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
        
    }

}
