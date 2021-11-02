//
//  ExtraSignUpViewController.swift
//  Knowing
//
//  Created by Jun on 2021/11/02.
//

import UIKit
import Then


class ExtraSignUpViewController: UIViewController {

    let topView = UIView()
    let footerView = UIScrollView()
    
    let backBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "backArrow"), for: .normal)
    }
    
    let smallTitleLabel = UILabel().then {
        $0.text = "딱 맞는 복지정보, 노잉이 찾아드릴게요!"
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        $0.textColor = .black
    }
    
    let largeTitleLabel = UILabel().then {
        $0.attributedText = NSAttributedString(string: "00님만의 혜택을 위해선\n추가 입력이 필요해요").withLineSpacing(6)
        $0.font = UIFont(name: "GodoM", size: 24)
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.numberOfLines = 2
    }
    
    let oneLabel = UILabel().then {
        $0.text = "1"
        $0.font = UIFont(name: "Roboto-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 249, green: 133, blue: 81)
    }
    
    let twoLabel = UILabel().then {
        $0.text = "2"
        $0.font = UIFont(name: "Roboto-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 249, green: 133, blue: 81)
        
    }
    
    let threeLabel = UILabel().then {
        $0.text = "3"
        $0.font = UIFont(name: "Roboto-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 249, green: 133, blue: 81)
    
    }
    
    let fourLabel = UILabel().then {
        $0.text = "4"
        $0.font = UIFont(name: "Roboto-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 249, green: 133, blue: 81)
        
    }
    
    let fiveLabel = UILabel().then {
        $0.text = "5"
        $0.font = UIFont(name: "Roboto-Bold", size: 14)
        $0.textColor = UIColor.rgb(red: 216, green: 216, blue: 216)
    }
    
    let progressView = UIProgressView().then {
        $0.tintColor = UIColor.rgb(red: 216, green: 216, blue: 216)
        $0.progressTintColor = UIColor.rgb(red: 255, green: 136, blue: 84)
        $0.progress = 0.2
        $0.layer.cornerRadius = 3.5
    }
    
    let subTitle1 = UILabel().then {
        $0.text = "카테고리 중 "
        $0.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.textColor = UIColor.rgb(red: 147, green: 147, blue: 147)
    }
    
    let subTitle2 = UIImageView(image: UIImage(named: "star")!).then {
        $0.contentMode = .scaleAspectFit
    }
    
    let subTitle3 = UILabel().then {
        $0.text = "은 필수 기재 사항이에요."
        $0.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 14)
        $0.textColor = UIColor.rgb(red: 147, green: 147, blue: 147)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
}

extension ExtraSignUpViewController {
    func setUI() {
        view.backgroundColor = .white
        safeArea.addSubview(topView)
        topView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        topView.addSubview(backBt)
        backBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(1)
            $0.leading.equalToSuperview().offset(20)
        }
        
        topView.addSubview(smallTitleLabel)
        smallTitleLabel.snp.makeConstraints {
            $0.top.equalTo(backBt.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(26)
        }
        
        topView.addSubview(largeTitleLabel)
        largeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(smallTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(26)
        }
        
        topView.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.top.equalTo(largeTitleLabel.snp.bottom).offset(51)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(-25)
            $0.height.equalTo(8)
        }
        
        topView.addSubview(oneLabel)
        oneLabel.snp.makeConstraints {
            $0.bottom.equalTo(progressView.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset((view.frame.width - 50) * 0.2 + 21)
        }
        
        topView.addSubview(twoLabel)
        twoLabel.snp.makeConstraints {
            $0.bottom.equalTo(progressView.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset((view.frame.width - 50) * 0.4 + 21)
        }
        
        topView.addSubview(threeLabel)
        threeLabel.snp.makeConstraints {
            $0.bottom.equalTo(progressView.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset((view.frame.width - 50) * 0.6 + 21)
        }
        
        topView.addSubview(fourLabel)
        fourLabel.snp.makeConstraints {
            $0.bottom.equalTo(progressView.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset((view.frame.width - 50) * 0.8 + 21)
        }
        
        topView.addSubview(fiveLabel)
        fiveLabel.snp.makeConstraints {
            $0.bottom.equalTo(progressView.snp.top).offset(-10)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        let subTitle = UIStackView(arrangedSubviews: [subTitle1, subTitle2, subTitle3]).then {
            $0.axis = .horizontal
            $0.spacing = 1
            
            $0.distribution = .fillProportionally
        }
        
        topView.addSubview(subTitle)
        subTitle.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(78)
            $0.trailing.equalToSuperview().offset(-77)
        }
        
        
        
        
    }
}
