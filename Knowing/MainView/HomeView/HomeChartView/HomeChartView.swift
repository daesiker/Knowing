//
//  HomeChartView.swift
//  Knowing
//
//  Created by Jun on 2021/10/27.
//

import Foundation
import UIKit

class HomeChartView: UIView {
    let imgView = UIImageView(image: UIImage(named: "chartView")!)
    
    let titleLb = UILabel().then {
        $0.text = "리즈님의 최대 수혜 금액"
        $0.font = UIFont(name: "GodoM", size: 17)
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
    }
    
    let maxMoneyLb = UILabel().then {
        $0.text = "250,000"
        $0.font = UIFont(name: "GodoB", size: 42)
        $0.textColor = UIColor.rgb(red: 185, green: 113, blue: 66)
    }
    
    let maxWonLb = UILabel().then {
        $0.text = "원"
        $0.textColor = UIColor.rgb(red: 180, green: 122, blue: 91)
        $0.font = UIFont(name: "GodoB", size: 20)
    }
    
    let maxMoneyBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "goMoney")!, for: .normal)
    }
    
    let minMoneyLb = UILabel().then {
        $0.text = "최소 80,000원"
        $0.textColor = UIColor.rgb(red: 210, green: 132, blue: 81)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18)
    }
    
    let chartTitleLb = UILabel().then {
        $0.text = "수혜 예상 복지"
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    let chartBorder = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 255, green: 198, blue: 141)
    }
    
    let chartCount = UILabel().then {
        $0.text = "50건"
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        
    }
    
    let chartView = AqiChartView(frame: .zero)
    
    let cvTitle = UILabel().then {
        $0.text = "카테고리별 맞춤 복지"
        $0.textColor = UIColor.rgb(red: 164, green: 97, blue: 61)
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeChartView {
    func setUI() {
        backgroundColor = UIColor.rgb(red: 255, green: 245, blue: 230)
        addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        imgView.addSubview(titleLb)
        titleLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(134)
            $0.centerX.equalToSuperview()
        }
        
        imgView.addSubview(maxMoneyLb)
        maxMoneyLb.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(96)
            $0.top.equalTo(titleLb.snp.bottom).offset(11)
        }
        
        imgView.addSubview(maxWonLb)
        maxWonLb.snp.makeConstraints {
            $0.top.equalTo(maxMoneyLb.snp.top).offset(12)
            $0.leading.equalTo(maxMoneyLb.snp.trailing).offset(2)
            
        }
        
        imgView.addSubview(maxMoneyBt)
        maxMoneyBt.snp.makeConstraints {
            $0.top.equalTo(titleLb.snp.bottom).offset(12)
            $0.leading.equalTo(maxWonLb.snp.trailing).offset(2)
        }
        
        imgView.addSubview(minMoneyLb)
        minMoneyLb.snp.makeConstraints {
            $0.top.equalTo(maxMoneyBt.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(chartTitleLb)
        chartTitleLb.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
        }
        
        addSubview(chartBorder)
        chartBorder.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(12)
            $0.leading.equalTo(chartTitleLb.snp.trailing).offset(7)
            
        }
        
        addSubview(chartCount)
        chartCount.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom)
            $0.leading.equalTo(chartTitleLb.snp.trailing).offset(7)
        }
        
        addSubview(chartView)
        chartView.snp.makeConstraints {
            $0.top.equalTo(chartTitleLb.snp.bottom).offset(22)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(246)
        }
        
    }
}
