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
        $0.text = "1건"
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        
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
