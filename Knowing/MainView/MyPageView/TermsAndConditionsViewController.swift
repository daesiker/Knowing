//
//  TermsAndConditionsViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/30.
//

import UIKit
import RxSwift
import RxCocoa

class TermsAndConditionsViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let titleLb = UILabel().then {
        $0.text = "문의 및 약관"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "GodoM", size: 23)
    }
    
    let termsBt = TermsButton("이용 약관")
    
    let personalInfoBt = TermsButton("개인정보 처리방침")
    
    let openSourceBt = TermsButton("오픈소스 라이선스")
    
    
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
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(backBt.snp.bottom).offset(19)
        }
        
        safeArea.addSubview(termsBt)
        termsBt.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(48)
        }
        
        safeArea.addSubview(personalInfoBt)
        personalInfoBt.snp.makeConstraints {
            $0.top.equalTo(termsBt.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(48)
        }
        
        safeArea.addSubview(openSourceBt)
        openSourceBt.snp.makeConstraints {
            $0.top.equalTo(personalInfoBt.snp.bottom).offset(20)
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
        
        openSourceBt.rx.tap
            .subscribe(onNext: {
                let vc = OpenSourceViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
        termsBt.rx.tap
            .subscribe(onNext: {
                let vc = PersonnalInfoViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
        
        personalInfoBt.rx.tap
            .subscribe(onNext: {
                let vc = PersonnalInfoViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)
    }
    
}


class TermsButton: UIButton {
    
    let title = UILabel().then {
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
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
        backgroundColor = UIColor.rgb(red: 255, green: 246, blue: 232)
        clipsToBounds = true
        layer.cornerRadius = 24
        
        addSubview(title)
        title.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-15.4)
            $0.centerY.equalToSuperview()
        }
        
    }
}
