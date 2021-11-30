//
//  NoticeViewController.swift
//  Knowing
//
//  Created by Jun on 2021/12/01.
//

import UIKit
import RxSwift
import RxCocoa

class NoticeViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let titleLb = UILabel().then {
        $0.text = "공지사항"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "GodoM", size: 18)
    }
    
    let separator = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 252, green: 245, blue: 235)
    }
    
    let noticeImageView = UIImageView(image: UIImage(named: "noAlarm")!)
    
    let noNoticeTitleLb = UILabel().then {
        $0.text = "아직은 올라온 공지사항이 없어요!"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
    }
    
    let noNoticeSubTitleLb = UILabel().then {
        $0.text = "추후 업데이트 시 공지가 올라올 예정이에요"
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        backBt.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        safeArea.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(20)
        }
        
        safeArea.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(12)
        }
        
        safeArea.addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        safeArea.addSubview(noticeImageView)
        noticeImageView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(174)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(noNoticeTitleLb)
        noNoticeTitleLb.snp.makeConstraints {
            $0.top.equalTo(noticeImageView.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        safeArea.addSubview(noNoticeSubTitleLb)
        noNoticeSubTitleLb.snp.makeConstraints {
            $0.top.equalTo(noNoticeTitleLb.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
    }
    

}
