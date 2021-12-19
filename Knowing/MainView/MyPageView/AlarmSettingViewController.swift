//
//  AlarmSettingViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/30.
//

import UIKit
import RxSwift
import RxCocoa

class AlarmSettingViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let titleLb = UILabel().then {
        $0.text = "알림 설정"
        $0.font = UIFont(name: "GodoM", size: 23)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
    }
    
    let pushTitleLb = UILabel().then {
        $0.text = "맞춤 정보 푸시 알림"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    let pushControlSwitch = UISwitch().then {
        $0.onTintColor = UIColor.rgb(red: 255, green: 136, blue: 84)
    }
    
    let pushSubTitleLb = UILabel().then {
        $0.text = "보다 편리한 나만의 복지 정보 관리를 위해 북마크 및 알림설정을 해둔 게시물의 신청 마감일 알림, 맞춤 복지 업데이트 등 중요한 소식 알림을 받을 수 있습니다."
        $0.textColor = UIColor.rgb(red: 169, green: 169, blue: 169)
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        $0.numberOfLines = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isRegistered = UIApplication.shared.isRegisteredForRemoteNotifications
        pushControlSwitch.setOn(isRegistered, animated: true)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        safeArea.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        
        safeArea.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalTo(backBt.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(25)
        }
        
        safeArea.addSubview(pushTitleLb)
        pushTitleLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(46)
            $0.leading.equalToSuperview().offset(25)
        }
        
        safeArea.addSubview(pushControlSwitch)
        pushControlSwitch.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(41)
            $0.trailing.equalToSuperview().offset(-25)
            $0.width.equalTo(48)
            $0.height.equalTo(27)
        }
        
        safeArea.addSubview(pushSubTitleLb)
        pushSubTitleLb.snp.makeConstraints {
            $0.top.equalTo(pushTitleLb.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        
    }
    
    func bind() {
        
        
        backBt.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        pushControlSwitch.rx.isOn
            .subscribe(onNext: { value in
                if value {
                    UIApplication.shared.registerForRemoteNotifications()
                } else {
                    UIApplication.shared.unregisterForRemoteNotifications()
                }
            }).disposed(by: disposeBag)
        
    }
    

}
