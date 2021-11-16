//
//  ExtraSignOne.swift
//  Knowing
//
//  Created by Jun on 2021/11/03.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class StepOneView: UIView {
    
    let vm = ExtraSignUpViewModel.instance
    var disposeBag = DisposeBag()
    
    let starImg = UIImageView(image: UIImage(named: "star")!)
    
    let residenceLb = UILabel().then {
        $0.text = "거주지"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    
    let cityBt = CustomPicker("시/도 선택")
    let guBt = CustomPicker("시/군/구 선택")
    
    let cityAlertLb = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        $0.textColor = UIColor.rgb(red: 255, green: 108, blue: 0)
    }
    
    let starImg2 = UIImageView(image: UIImage(named: "star")!)
    
    let specialLb = UILabel().then {
        $0.text = "특별사항"
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        $0.textColor = UIColor.rgb(red: 102, green: 102, blue: 102)
    }
    let specialBt = CustomPicker("특별사항 선택")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        addSubview(starImg)
        starImg.snp.makeConstraints {
            $0.top.equalToSuperview().offset(55)
            $0.leading.equalToSuperview().offset(26)
        }
        
        addSubview(residenceLb)
        residenceLb.snp.makeConstraints {
            $0.top.equalToSuperview().offset(52)
            $0.leading.equalTo(starImg.snp.trailing).offset(4)
        }
        
       addSubview(cityBt)
        cityBt.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.top.equalTo(residenceLb.snp.bottom).offset(20)
            $0.width.equalTo(113)
        }
        
        addSubview(guBt)
        guBt.snp.makeConstraints {
            $0.top.equalTo(residenceLb.snp.bottom).offset(20)
            $0.leading.equalTo(cityBt.snp.trailing).offset(26)
            $0.width.equalTo(112)
        }
        
        addSubview(cityAlertLb)
        cityAlertLb.snp.makeConstraints {
            $0.top.equalTo(cityBt.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(25)
        }
        
        addSubview(starImg2)
        starImg2.snp.makeConstraints {
            $0.top.equalTo(cityBt.snp.bottom).offset(47)
            $0.leading.equalToSuperview().offset(25)
        }
        
        addSubview(specialLb)
        specialLb.snp.makeConstraints {
            $0.top.equalTo(cityBt.snp.bottom).offset(44)
            $0.leading.equalTo(starImg2.snp.trailing).offset(3)
        }
        
        addSubview(specialBt)
        specialBt.snp.makeConstraints {
            $0.top.equalTo(specialLb.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(25)
            $0.width.equalTo(113)
        }
        
        
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        cityBt.rx.tap
            .bind(to: self.vm.stepOne.input.cityObserver)
            .disposed(by: disposeBag)
        
        guBt.rx.tap
            .map { self.cityBt.label.text ?? ""}
            .bind(to: self.vm.stepOne.input.guObserver)
            .disposed(by: disposeBag)
        
        specialBt.rx.tap
            .bind(to: self.vm.stepOne.input.specialObserver)
            .disposed(by: disposeBag)
    }
    
    
    func bindOutput() {
        vm.stepOne.output.cityValue
            .drive(onNext:{ value in
                self.cityBt.label.text = value
                self.cityBt.label.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
                self.cityAlertLb.text = ""
            })
            .disposed(by: disposeBag)
        
        vm.stepOne.output.goGuView
            .drive(onNext: { value in
                if value == "시/도 선택" {
                    self.cityAlertLb.text = "[시/도]를 먼저 선택해주세요."
                    self.cityBt.label.textColor = UIColor.rgb(red: 255, green: 108, blue: 0)
                } else {
                    self.cityAlertLb.text = ""
                    self.cityBt.label.textColor = UIColor.rgb(red: 194, green: 194, blue: 194)
                }
            })
            .disposed(by: disposeBag)
        
        vm.stepOne.output.guValue
            .drive(onNext: { value in
                self.guBt.label.text = value
                self.guBt.label.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
            }).disposed(by: disposeBag)
        
        
        vm.stepOne.output.dismissSpecialView
            .drive(onNext: {value in
                self.specialBt.label.text = value
                self.specialBt.label.textColor = UIColor.rgb(red: 65, green: 65, blue: 65)
            }).disposed(by: disposeBag)
        
        
    }
    
    
}

