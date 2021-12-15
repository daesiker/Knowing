//
//  SortViewController.swift
//  Knowing
//
//  Created by Jun on 2021/12/13.
//

import Foundation
import UIKit
import PanModal
import RxCocoa
import RxSwift

class SortViewController: UIViewController {
    
    let vm = MainTabViewModel.instance
    let disposeBag = DisposeBag()
    
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
        $0.setTitleColor(UIColor.rgb(red: 176, green: 176, blue: 176), for: .normal)
        $0.backgroundColor = .clear//UIColor.rgb(red: 255, green: 238, blue: 211)
        $0.layer.cornerRadius = 23.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 13, left: 126, bottom: 13, right: 125)
    }
    
    let low2highBt = UIButton(type: .custom).then {
        $0.setTitle("낮은 금액순", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.setTitleColor(UIColor.rgb(red: 176, green: 176, blue: 176), for: .normal)
        $0.backgroundColor = .clear//UIColor.rgb(red: 255, green: 238, blue: 211)
        $0.layer.cornerRadius = 23.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 13, left: 126, bottom: 13, right: 125)
    }
    
    let lastestDateBt = UIButton(type: .custom).then {
        $0.setTitle("마감일순", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        $0.setTitleColor(UIColor.rgb(red: 176, green: 176, blue: 176), for: .normal)
        $0.backgroundColor = .clear//UIColor.rgb(red: 255, green: 238, blue: 211)
        $0.layer.cornerRadius = 23.0
        $0.contentEdgeInsets = UIEdgeInsets(top: 13, left: 135, bottom: 13, right: 134)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
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
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
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
        switch vm.sortType {
        case .lastestDate:
            lastestDateBt.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
            lastestDateBt.setTitleColor(UIColor.rgb(red: 255, green: 136, blue: 84), for: .normal)
        case .maxMoney:
            high2LowBt.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
            high2LowBt.setTitleColor(UIColor.rgb(red: 255, green: 136, blue: 84), for: .normal)
        case .minMoney:
            low2highBt.backgroundColor = UIColor.rgb(red: 255, green: 238, blue: 211)
            low2highBt.setTitleColor(UIColor.rgb(red: 255, green: 136, blue: 84), for: .normal)
        }
    }
    
    func bind() {
        
        high2LowBt.rx.tap
            .map { SortType.maxMoney }
            .bind(to: vm.input.sortObserver)
            .disposed(by: disposeBag)
        
        low2highBt.rx.tap
            .map { SortType.minMoney }
            .bind(to: vm.input.sortObserver)
            .disposed(by: disposeBag)
        
        lastestDateBt.rx.tap
            .map { SortType.lastestDate }
            .bind(to: vm.input.sortObserver)
            .disposed(by: disposeBag)
        
        vm.output.sortValue.subscribe(onNext: { _ in
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
    }
}


extension SortViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(self.view.frame.height * 0.35)
        }
    
    //Modal background color
    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.2)
    }
    
    //Whether to round the top corners of the modal
    var shouldRoundTopCorners: Bool {
        return true
    }
    
}
