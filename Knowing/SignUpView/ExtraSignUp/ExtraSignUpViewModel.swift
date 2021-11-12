//
//  ExtraSignUpViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/04.
//

import Foundation
import RxSwift
import RxCocoa

class ExtraSignUpViewModel {
    
    static let instance = ExtraSignUpViewModel()
    
    var user = User()
    let disposeBag = DisposeBag()
    var rootView = RootView()
    var stepOne = StepOne()
    var stepTwo = StepTwo()
    var stepThree = StepThree()
    var currentStep = SignUpStep.step1
    
    
    init() {
        
        bindStepOne()
        bindStepTwo()
        bindStepThree()
        
        rootView.output.nextBtValid = Driver.combineLatest(stepOne.output.cityValue, stepOne.output.guValue, stepOne.output.dismissSpecialView) //여기서 스케문으로 나눌꺼임
            .map { $0 != "" && $1 != "" && $2 != ""}
            .asDriver(onErrorJustReturn: false)
        rootView.input.nextBt.subscribe { event in
            switch event {
            case .completed:
                print("completed")
            case .next(_):
                print("next")
            case .error(let error):
                print(error)
            }
        }.disposed(by: disposeBag)
        rootView.output.goSignUp = rootView.input.nextBt.asSignal()
    }
    
    func bindStepTwo() {
        
        stepTwo.input.incomeObserver.subscribe(onNext: {value in
            incomeQuintile(value)
        }).disposed(by: disposeBag)
        
        stepTwo.input.employObserver.subscribe(onNext: {value in
            if value == "전체" {
                if self.user.employStatus.contains(value) {
                    self.user.employStatus = []
                } else {
                    self.user.employStatus = [value]
                }
            } else {
                if self.user.employStatus == ["전체"] {
                    self.user.employStatus = [value]
                } else if self.user.employStatus.contains(value) {
                    let index = self.user.employStatus.firstIndex(of: value) ?? 0
                    self.user.employStatus.remove(at: index)
                } else {
                    self.user.employStatus.append(value)
                }
            }
            print(self.user.employStatus)
        }).disposed(by: disposeBag)
        
        stepTwo.input.employObserver
            .map { _ in
                self.user.employStatus
            }
        
        
        
        func incomeQuintile(_ value: Int) {
            if value <= 1462887 {
                self.user.money1 = "1분위"
                self.user.money2 = "30%"
            } else if value <= 2438145 {
                self.user.money1 = "2분위"
                self.user.money2 = "50%"
            } else if value <= 3413403 {
                self.user.money1 = "3분위"
                self.user.money2 = "70%"
            } else if value <= 4388661 {
                self.user.money1 = "4분위"
                self.user.money2 = "90%"
            } else if value <= 4876290 {
                self.user.money1 = "5분위"
                self.user.money2 = "100%"
            } else if value <= 6339177 {
                self.user.money1 = "6분위"
                self.user.money2 = "130%"
            } else if value <= 7314435 {
                self.user.money1 = "7분위"
                self.user.money2 = "150%"
            } else if value <= 9752580 {
                self.user.money1 = "8분위"
                self.user.money2 = "200%"
            } else if value <= 14628870 {
                self.user.money1 = "9분위"
                self.user.money2 = "300%"
            } else {
                self.user.money1 = "10분위"
                self.user.money2 = "-"
            }
        }
    }
    
    func bindStepOne() {
        
        stepOne.input.cityObserver
            .bind(to: self.stepOne.output.goCityView)
            .disposed(by: disposeBag)
        stepOne.input.specialObserver
            .bind(to: self.stepOne.output.goSpecialView)
            .disposed(by: disposeBag)
        stepOne.input.specialNoneValueObserver
            .subscribe(onNext: {
                if self.user.specialStatus.contains("none") {
                    self.user.specialStatus = []
                } else {
                    self.user.specialStatus = ["none"]
                }
            })
            .disposed(by: disposeBag)
        
        stepOne.output.goGuView = stepOne.input.guObserver.asDriver(onErrorJustReturn: "시/도 선택")
        stepOne.output.cityValue = stepOne.input.cityValueObserver.asDriver(onErrorJustReturn: "")
        stepOne.output.guValue = stepOne.input.guValueObserver.asDriver(onErrorJustReturn: "")
        
        
        
        stepOne.output.spcialNoneValue = stepOne.input.specialNoneValueObserver.map{ self.user.specialStatus.contains("none") }.asDriver(onErrorJustReturn: false)
        
        stepOne.input.specialValueObserver.subscribe(onNext: {value in
            if !self.user.specialStatus.contains("none") {
                if self.user.specialStatus.contains(value) {
                    let index = self.user.specialStatus.firstIndex(of: value) ?? 0
                    self.user.specialStatus.remove(at: index)
                } else {
                    self.user.specialStatus.append(value)
                }
            }
        }).disposed(by: disposeBag)
        
        stepOne.output.specialBtValid = Driver.combineLatest(stepOne.input.specialNoneValueObserver.asDriver(onErrorJustReturn: ()), stepOne.input.specialValueObserver.asDriver(onErrorJustReturn: ""))
            .map({ _, _ in
                self.user.specialStatus.count == 0 ? false : true
            }).asDriver(onErrorJustReturn: false)
        
        stepOne.output.dismissSpecialView = Driver.just(stepOne.input.specialButtonObserver).map({ _ in
            if self.user.specialStatus.contains("none") {
                return "선택사항 없음"
            } else {
                return "선택사항 \(self.user.specialStatus.count)개"
            }
        }).asDriver(onErrorJustReturn: "")
        
    }
    
    func bindStepThree() {
        stepThree.input.recordsObserver
            .subscribe(onNext: { value in
                if value == "전체" {
                    if self.user.records.contains(value) {
                        self.user.records = []
                    } else {
                        self.user.records = [value]
                    }
                } else {
                    if self.user.records == ["전체"] {
                        self.user.records = [value]
                    } else if self.user.records.contains(value) {
                        let index = self.user.records.firstIndex(of: value) ?? 0
                        self.user.records.remove(at: index)
                    } else {
                        self.user.records.append(value)
                    }
                }
            }).disposed(by: disposeBag)
        
        stepThree.output.buttonValid = stepThree.input.recordsObserver.map { _ in
            self.user.records.count != 0
        }.asDriver(onErrorJustReturn: false)
    }
    
    
}

extension ExtraSignUpViewModel {
    
    struct RootView {
        
        let input = Input()
        var output = Output()
        
        struct Input {
            let nextBt = PublishRelay<Void>()
            let dismissBt = PublishRelay<Void>()
        }
        
        struct Output {
            var nextBtValid = BehaviorRelay<Bool>(value: false).asDriver(onErrorJustReturn: false)
            var goSignUp:Signal<Void> = PublishRelay<Void>().asSignal()
        }
    }
    
    struct StepOne {
        let input = Input()
        var output = Output()
        
        struct Input {
            let cityObserver = PublishRelay<Void>()
            let guObserver = PublishRelay<String>()
            let cityValueObserver = PublishRelay<String>()
            let guValueObserver = PublishRelay<String>()
            
            let specialObserver = PublishRelay<Void>() //stepOne에서 눌렀을 때
            let specialValueObserver = PublishRelay<String>() //collectionView 눌렀을때
            let specialNoneValueObserver = PublishRelay<Void>() //none Button 눌렀을때
            let specialButtonObserver = PublishRelay<Void>() //적용 버튼 눌렀을때
        }
        
        struct Output {
            let goCityView = PublishRelay<Void>()
            var goGuView = PublishRelay<String>().asDriver(onErrorJustReturn: "시/도 선택")
            var cityValue:Driver<String> = PublishRelay<String>().asDriver(onErrorJustReturn: "")
            var guValue:Driver<String> = PublishRelay<String>().asDriver(onErrorJustReturn: "")
            
            
            var specialValue:Driver<String> = PublishRelay<String>().asDriver(onErrorJustReturn: "")
            let goSpecialView = PublishRelay<Void>()
            var spcialNoneValue = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
            var specialBtValid = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
            var dismissSpecialView = PublishRelay<String>().asDriver(onErrorJustReturn: "")
        }
        
    }
    
    struct StepTwo {
        let input = Input()
        let output = Output()
        
        struct Input {
            let incomeObserver = PublishRelay<Int>()
            let employObserver = PublishRelay<String>()
        }
        
        struct Output {
            var buttonValid = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
            var employValid = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        }
    }
    
    struct StepThree {
        
        let input = Input()
        var output = Output()
        
        struct Input {
            let recordsObserver = PublishRelay<String>()
            let schoolViewObserver = PublishRelay<Void>()
        }
        
        struct Output {
            var buttonValid = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        }
        
        
    }
    
    
    
}

