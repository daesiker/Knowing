//
//  SortViewController.swift
//  Knowing
//
//  Created by Jun on 2021/12/13.
//

import Foundation
import UIKit

class SortViewController: UIViewController {
    
    let sortType:SortType
    
    let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40.0
    }
    let titleLabel = UILabel().then {
        $0.text = "정렬"
        $0.textColor = UIColor.rgb(red: 101, green: 101, blue: 101)
        $0.font = UIFont(name: "GodoM", size: 20)
    }
    
    let cancelBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "largeCancel")!, for: .normal)
    }
    
    let separator = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 221, green: 221, blue: 221)
    }
    
    let high2LowBt = UIButton(type: .custom).then {
        $0.setTitle("높은 금액순", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.titleLabel?.textColor = UIColor.rgb(red: 176, green: 176, blue: 176)
        $0.backgroundColor = .clear//UIColor.rgb(red: 255, green: 238, blue: 211)
        $0.layer.cornerRadius = 23.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 13, left: 126, bottom: 13, right: 125)
    }
    
    let low2highBt = UIButton(type: .custom).then {
        $0.setTitle("낮은 금액순", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.titleLabel?.textColor = UIColor.rgb(red: 176, green: 176, blue: 176)
        $0.backgroundColor = .clear//UIColor.rgb(red: 255, green: 238, blue: 211)
        $0.layer.cornerRadius = 23.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 13, left: 126, bottom: 13, right: 125)
    }
    
    let lastestDateBt = UIButton(type: .custom).then {
        $0.setTitle("마감일순", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.titleLabel?.textColor = UIColor.rgb(red: 176, green: 176, blue: 176)
        $0.backgroundColor = .clear//UIColor.rgb(red: 255, green: 238, blue: 211)
        $0.layer.cornerRadius = 23.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 13, left: 135, bottom: 13, right: 134)
    }
    
    init(sortType: SortType) {
        self.sortType = sortType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getInitialValue()
    }
    
    func setUI() {
        view.backgroundColor = .clear
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.centerX.equalToSuperview()
        }
        
        backgroundView.addSubview(cancelBt)
        cancelBt.snp.makeConstraints {
            $0.top.equalToSuperview().offset(21)
            $0.trailing.equalToSuperview().offset(-31)
        }
        
        backgroundView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        backgroundView.addSubview(high2LowBt)
        high2LowBt.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        backgroundView.addSubview(low2highBt)
        low2highBt.snp.makeConstraints {
            $0.top.equalTo(high2LowBt.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
        
        backgroundView.addSubview(lastestDateBt)
        lastestDateBt.snp.makeConstraints {
            $0.top.equalTo(low2highBt.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
    }
    
    func getInitialValue() {
        switch sortType {
        case .lastestDate:
            lastestDateBt.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
            lastestDateBt.titleLabel?.textColor = UIColor.rgb(red: 255, green: 136, blue: 84)
        case .maxMoney:
            high2LowBt.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
            high2LowBt.titleLabel?.textColor = UIColor.rgb(red: 255, green: 136, blue: 84)
        case .minMoney:
            low2highBt.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
            low2highBt.titleLabel?.textColor = UIColor.rgb(red: 255, green: 136, blue: 84)
        }
    }
    
    
}


