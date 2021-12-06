//
//  NotificationViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/20.
//

import UIKit
import Foundation
import Then
import SwipeCellKit

class NotificationViewController: UIViewController {

    let vm = MainTabViewModel.instance
    
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
    
    let removeBt = RemoveButton().then {
        $0.alpha = 0
    }
    
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
    
    let notificationCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.alpha = 0
        return collectionView
    }()
    
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
        
        view.addSubview(removeBt)
        removeBt.snp.makeConstraints {
            $0.top.equalTo(countLb.snp.bottom).offset(11)
            $0.trailing.equalToSuperview().offset(-13)
        }
        
        view.addSubview(notificationCV)
        notificationCV.snp.makeConstraints {
            $0.top.equalTo(removeBt.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-91)
        }
        
        view.addSubview(noAlarmImgView)
        noAlarmImgView.snp.remakeConstraints {
            $0.top.equalTo(countLb.snp.bottom).offset(129)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(noAlarmTitleLb)
        noAlarmTitleLb.snp.remakeConstraints {
            $0.top.equalTo(noAlarmImgView.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        view.addSubview(noAlarmSubTitleLb)
        noAlarmSubTitleLb.snp.remakeConstraints {
            $0.top.equalTo(noAlarmTitleLb.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(232)
        }
        
    }
    
    func fetchedData() {
        
        if vm.user.Alarm.count == 0 {
            removeBt.alpha = 0
            notificationCV.alpha = 0
            noAlarmImgView.alpha = 1
            noAlarmTitleLb.alpha = 1
            noAlarmSubTitleLb.alpha = 1
        } else {
            removeBt.alpha = 1
            notificationCV.alpha = 1
            noAlarmImgView.alpha = 0
            noAlarmTitleLb.alpha = 0
            noAlarmSubTitleLb.alpha = 0
        }
    }
    
    func setCV() {
        notificationCV.delegate = self
        notificationCV.dataSource = self
        
    }
    
}

extension NotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.user.Alarm.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! NotificationCell
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 20, bottom: 14, right: 20)
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

class NotificationCell: SwipeCollectionViewCell {
    
    let titleLb = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    let subTitleLb = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        $0.numberOfLines = 2
    }
    
    let dateLb = UILabel().then {
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13)
        $0.textColor = UIColor.rgb(red: 148, green: 148, blue: 148)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 30
    }
    
    func setupView() {
        backgroundColor = .clear
        
        contentView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-18)
        }
        
        contentView.addSubview(subTitleLb)
        subTitleLb.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-18)
        }
        
        contentView.addSubview(dateLb)
        dateLb.snp.makeConstraints {
            $0.top.equalTo(subTitleLb.snp.bottom).offset(11)
            $0.leading.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().offset(-18)
        }
        
    }
    
    func configure(_ alarm: GetAlarm) {
        
        titleLb.text = alarm.title
        subTitleLb.text = alarm.subTitle
        dateLb.text = alarm.date
        
        if alarm.isRead == "" {
            
        } else {
            
        }
        
    }
    
}
