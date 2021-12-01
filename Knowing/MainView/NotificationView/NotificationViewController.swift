//
//  NotificationViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/20.
//

import UIKit
import Foundation
import Then

class NotificationViewController: UIViewController {

    let titleLb = UILabel().then {
        $0.text = "알림"
        $0.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        $0.font = UIFont(name: "GodoM", size: 26)
    }
    
    let subTitleLb = UILabel().then {
        $0.text = "읽지 않은 알림"
        $0.textColor = UIColor.rgb(red: 135, green: 135, blue: 135)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 17)
    }
    
    let removeBt = RemoveButton()
    
    let countLb = PaddingLabel().then {
        $0.text = "0건"
        $0.textColor = .white
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.backgroundColor = UIColor.rgb(red: 255, green: 142, blue: 59)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 14
        $0.topInset = 7
        $0.bottomInset = 7
        $0.leftInset = 8
        $0.rightInset = 8
    }
    
    let noAlarmImgView = UIImageView(image: UIImage(named: "noAlarm")!)
    
    let noAlarmTitleLb = UILabel().then {
        $0.text = "알람 설정한 게시물이 없습니다."
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    let noAlarmSubTitleLb = UILabel().then {
        $0.text = "기억해둘 복지에 알림 아이콘을 눌러 두면\n신청 마감일이 다가왔을 때 알림을 드려요!"
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        $0.numberOfLines = 2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainTabViewModel.instance.bcObserver.accept(.white)
        setUI()
        
        
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

extension NotificationViewController {
    
    func setUI() {
        view.backgroundColor = .white
        
        safeArea.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(subTitleLb)
        subTitleLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(countLb)
        countLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(8)
            $0.leading.equalTo(subTitleLb.snp.trailing).offset(12)
        }
        
        view.addSubview(noAlarmImgView)
        noAlarmImgView.snp.makeConstraints {
            $0.top.equalTo(countLb.snp.bottom).offset(129)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(noAlarmTitleLb)
        noAlarmTitleLb.snp.makeConstraints {
            $0.top.equalTo(noAlarmImgView.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(noAlarmSubTitleLb)
        noAlarmSubTitleLb.snp.makeConstraints {
            $0.top.equalTo(noAlarmTitleLb.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(232)
        }
        
//        view.addSubview(removeBt)
//        removeBt.snp.makeConstraints {
//            $0.top.equalTo(countLb.snp.bottom).offset(11)
//            $0.trailing.equalToSuperview().offset(-13)
//        }
        
        
        
    }
    
}


class RemoveButton: UIButton {
    
    let image = UIImageView(image: UIImage(named: "trashA")!)
    let title = UILabel().then {
        $0.text = "전체 삭제"
        $0.textColor = UIColor.rgb(red: 166, green: 166, blue: 166)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(image)
        image.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.bottom.equalToSuperview().offset(-7)
            $0.leading.equalToSuperview().offset(8)
        }
        
        addSubview(title)
        title.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(5)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
