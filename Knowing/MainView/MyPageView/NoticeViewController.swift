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
    
    let alarmView = UIView()
    
    let newAlarmImg = UIImageView(image: UIImage(named: "newAlarm"))
    
    let titleLb1 = UILabel().then {
        $0.text = "knowing 앱 오픈 안내"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    let dateLb = UILabel().then {
        $0.text = "2021.12.10"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
    }
    
    var isDetail:Bool = false
    
    let moreBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "docDetail_close"), for: .normal)
    }
    
    let detailView = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 248, blue: 236)
    }
    
    let detailLb = UILabel().then {
        $0.text = "안녕하세요 복지 정보 제공 서비스의 새로운 길잡이 노잉입니다.\n\n많은 노력을 기울인 끝에 노잉이 처음으로 인사드립니다^^\n\n앞으로도 노잉을 이용하는 여러분들이 편리하게 맞춤 복지 정보를 만나고, 관리할 수 있도록 새로운 복지 정보를 비롯한 여러 기능들을 꾸준히 업데이트 할 예정입니다.\n\n여러분들의 많은 응원을 부탁드리며, 이용시 불편한 사항이나 개선 사항이 있다면 언제든지 문의해주세요. 감사합니다 :)"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15)
        $0.numberOfLines = 0
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
        
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
        
        makeCell()
        
//        safeArea.addSubview(noticeImageView)
//        noticeImageView.snp.makeConstraints {
//            $0.top.equalTo(separator.snp.bottom).offset(174)
//            $0.centerX.equalToSuperview()
//        }
//
//        safeArea.addSubview(noNoticeTitleLb)
//        noNoticeTitleLb.snp.makeConstraints {
//            $0.top.equalTo(noticeImageView.snp.bottom).offset(2)
//            $0.centerX.equalToSuperview()
//        }
//
//        safeArea.addSubview(noNoticeSubTitleLb)
//        noNoticeSubTitleLb.snp.makeConstraints {
//            $0.top.equalTo(noNoticeTitleLb.snp.bottom).offset(7)
//            $0.centerX.equalToSuperview()
//        }
    }
    
    func makeCell() {
        safeArea.addSubview(alarmView)
        alarmView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(separator.snp.bottom)
            $0.height.equalTo(86)
        }
        
        alarmView.addSubview(newAlarmImg)
        newAlarmImg.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.leading.equalToSuperview().offset(20)
        }
        
        alarmView.addSubview(titleLb1)
        titleLb1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalTo(newAlarmImg.snp.trailing).offset(6)
        }
        
        alarmView.addSubview(moreBt)
        moreBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        alarmView.addSubview(dateLb)
        dateLb.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(titleLb1.snp.bottom).offset(10)
        }
        
        safeArea.addSubview(detailView)
        detailView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(alarmView.snp.bottom)
        }
        
        detailView.addSubview(detailLb)
        detailLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.bottom.equalToSuperview().offset(-22)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        
    }
    
    func bind() {
        backBt.rx.tap
            .subscribe(onNext: {
                self.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        moreBt.rx.tap
            .subscribe(onNext: {
                if self.isDetail {
                    self.detailView.alpha = 0
                    self.moreBt.setImage(UIImage(named: "docDetail_close"), for: .normal)
                } else {
                    self.detailView.alpha = 1
                    self.moreBt.setImage(UIImage(named: "docDetail_open"), for: .normal)
                }
            }).disposed(by: disposeBag)
    }
    
    
}

class NoticeCell: UICollectionViewCell {
    
    let newAlarmImg = UIImageView(image: UIImage(named: "newAlarm"))
    
    let titleLb = UILabel().then {
        $0.text = "knowing 앱 오픈 안내"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
    }
    
    let dateLb = UILabel().then {
        $0.text = "2021.12.10"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.textColor = UIColor.rgb(red: 146, green: 146, blue: 146)
    }
    
    let moreBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "docDetail_close"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
    }
    
}
