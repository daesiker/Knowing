//
//  MyPageViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/20.
//

import UIKit
import Foundation
import Then
import RxSwift
import RxCocoa

class MyPageViewController: UIViewController {
    
    let vm = MainTabViewModel.instance
    let disposeBag = DisposeBag()
    
    let profileView = UIImageView(image: UIImage(named: "myPage_profile")!)
    
    let nameLb = UILabel().then {
        $0.textColor = UIColor.rgb(red: 255, green: 142, blue: 59)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24)
    }
    
    let subLabel = UILabel().then {
        $0.text = "변경하고 싶으신 정보가 있으신가요?"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 115, green: 115, blue: 115)
    }
    
    let userInfoView = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 243, blue: 216)
        $0.layer.cornerRadius = 30
    }
    
    let userInfoTitle = UILabel().then {
        $0.text = "회원 정보 설정"
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    let userInfoBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named:"myPage_userinfo"), for: .normal)
    }
    
    let alarmSettingView = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 228, blue: 182)
        $0.layer.cornerRadius = 30
    }
    
    let alarmSettingBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "mypage_alarm"), for: .normal)
    }
    
    let alarmSettingTitle = UILabel().then {
        $0.text = "알림 설정"
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    let categorySettingView = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 228, blue: 182)
        $0.layer.cornerRadius = 30
    }
    
    let categorySettingTitle = UILabel().then {
        $0.text = "복지 카테고리\n설정"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    let categorySettingBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "mypage_category"), for: .normal)
    }
    
    let noticeView = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 243, blue: 216)
        $0.layer.cornerRadius = 30
    }
    
    let noticeTitle = UILabel().then {
        $0.text = "공지 사항"
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    let noticeSettingBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "mypage_notice"), for: .normal)
    }
    
    let termsBt = MyPageButton("문의 및 약관")
    
    let logoutBt = MyPageButton("로그아웃")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainTabViewModel.instance.bcObserver.accept(.white)
        setUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
}

extension MyPageViewController {
    
    func setUI() {
        view.backgroundColor = .white
        
        nameLb.text = vm.user.name + "님"
        
        safeArea.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(27)
            $0.leading.equalToSuperview().offset(29)
        }
        
        safeArea.addSubview(nameLb)
        nameLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(23)
            $0.leading.equalTo(profileView.snp.trailing).offset(16)
        }
        
        safeArea.addSubview(subLabel)
        subLabel.snp.makeConstraints {
            $0.top.equalTo(nameLb.snp.bottom).offset(13)
            $0.leading.equalTo(profileView.snp.trailing).offset(16)
        }
        
        safeArea.addSubview(userInfoView)
        userInfoView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.top.equalTo(subLabel.snp.bottom).offset(38)
            $0.width.equalTo((self.view.frame.width - 83) / 2)
            $0.height.equalTo(169)
        }
        
        userInfoView.addSubview(userInfoTitle)
        userInfoTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.centerX.equalToSuperview()
        }
        
        userInfoView.addSubview(userInfoBt)
        userInfoBt.snp.makeConstraints {
            $0.top.equalTo(userInfoTitle.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(alarmSettingView)
        alarmSettingView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalTo(subLabel.snp.bottom).offset(38)
            $0.width.equalTo((self.view.frame.width - 83) / 2)
            $0.height.equalTo(169)
        }
        
        alarmSettingView.addSubview(alarmSettingTitle)
        alarmSettingTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.centerX.equalToSuperview()
        }
        
        alarmSettingView.addSubview(alarmSettingBt)
        alarmSettingBt.snp.makeConstraints {
            $0.top.equalTo(alarmSettingTitle.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(categorySettingView)
        categorySettingView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.top.equalTo(userInfoView.snp.bottom).offset(29)
            $0.width.equalTo((self.view.frame.width - 83) / 2)
            $0.height.equalTo(169)
        }
        
        categorySettingView.addSubview(categorySettingTitle)
        categorySettingTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.centerX.equalToSuperview()
        }
        
        categorySettingView.addSubview(categorySettingBt)
        categorySettingBt.snp.makeConstraints {
            $0.top.equalTo(categorySettingTitle.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(categorySettingView)
        categorySettingView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.top.equalTo(userInfoView.snp.bottom).offset(29)
            $0.width.equalTo((self.view.frame.width - 83) / 2)
            $0.height.equalTo(169)
        }
        
        categorySettingView.addSubview(categorySettingTitle)
        categorySettingTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.centerX.equalToSuperview()
        }
        
        categorySettingView.addSubview(categorySettingBt)
        categorySettingBt.snp.makeConstraints {
            $0.top.equalTo(categorySettingTitle.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(noticeView)
        noticeView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalTo(userInfoView.snp.bottom).offset(29)
            $0.width.equalTo((self.view.frame.width - 83) / 2)
            $0.height.equalTo(169)
        }
        
        noticeView.addSubview(noticeTitle)
        noticeTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.centerX.equalToSuperview()
        }
        
        noticeView.addSubview(noticeSettingBt)
        noticeSettingBt.snp.makeConstraints {
            $0.top.equalTo(noticeTitle.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(termsBt)
        termsBt.snp.makeConstraints {
            $0.top.equalTo(noticeView.snp.bottom).offset(19)
            $0.leading.equalToSuperview().offset(30)
            $0.width.equalTo((self.view.frame.width - 83) / 2)
        }
        
        view.addSubview(logoutBt)
        logoutBt.snp.makeConstraints {
            $0.top.equalTo(noticeView.snp.bottom).offset(19)
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.equalTo((self.view.frame.width - 83) / 2)
            
        }
        
    }
    
    func bind() {
        termsBt.rx.tap
            .subscribe(onNext: {
                let vc = TermsAndConditionsViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        alarmSettingBt.rx.tap
            .subscribe(onNext: {
                let vc = AlarmSettingViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
        categorySettingBt.rx.tap
            .subscribe(onNext: {
                let vm = AddPostCategoryViewModel(isModify: true)
                vm.user = self.vm.user
                let vc = AddPostCategoryViewController(vm)
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        userInfoBt.rx.tap
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
        
        noticeSettingBt.rx.tap
            .subscribe(onNext: {
                let vc = NoticeViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
    }
    
}



class MyPageButton: UIButton {
    
    let title = UILabel().then {
        $0.text = "문의 및 약관"
        $0.textColor = UIColor.rgb(red: 178, green: 178, blue: 178)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    let imgView = UIImageView(image: UIImage(named: "myPage_arrow")!)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ text: String) {
        self.init()
        title.text = text
    }
    
    func setUI() {
        backgroundColor = UIColor.rgb(red: 242, green: 242, blue: 242)
        isUserInteractionEnabled = true
        clipsToBounds = true
        layer.cornerRadius = 25
        
        addSubview(title)
        title.snp.makeConstraints {
            $0.top.equalToSuperview().offset(17)
            $0.bottom.equalToSuperview().offset(-17)
            $0.leading.equalToSuperview().offset(25)
        }
        
        addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-22.5)
            $0.centerY.equalToSuperview()
        }
    }
    
}
