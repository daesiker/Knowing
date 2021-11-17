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
    var stepFour = StepFour()
    var stepFive = StepFive()
    var currentStep = SignUpStep.step1
    
    
    init() {
        
        bindStepOne()
        bindStepTwo()
        bindStepThree()
        bindStepFour()
        bindStepFive()
        bindRootView()
        
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
            let specialNoneValueObserver = PublishRelay<String>() //none Button 눌렀을때
            let specialButtonObserver = PublishRelay<Void>() //적용 버튼 눌렀을때
        }
        
        struct Output {
            let goCityView = PublishRelay<Void>()
            var goGuView = PublishRelay<String>().asDriver(onErrorJustReturn: "시/도 선택")
            var cityValue:Driver<String> = PublishRelay<String>().asDriver(onErrorJustReturn: "")
            var guValue:Driver<String> = PublishRelay<String>().asDriver(onErrorJustReturn: "")
            
            let goSpecialView = PublishRelay<Void>() //그냥 스페셜로 가는 output
            var specialValue:Driver<String> = PublishRelay<String>().asDriver(onErrorJustReturn: "")
            var spcialNoneValue = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
            var specialBtValid = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
            var dismissSpecialView = PublishRelay<String>().asDriver(onErrorJustReturn: "")
            
            var nextBtValid = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        }
        
    }
    
    struct StepTwo {
        let input = Input()
        var output = Output()
        
        struct Input {
            let incomeObserver = PublishRelay<String>()
            let employObserver = PublishRelay<String>()
        }
        
        struct Output {
            var buttonValid = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
            
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
    
    struct StepFour {
        
        let input = Input()
        var output = Output()
        
        struct Input {
            let mainMajorObserver = PublishRelay<String>()
            let subMajorObserver = PublishRelay<String>()
        }
        
        struct Output {
            var buttonValid = BehaviorRelay<Bool>(value: true).asDriver(onErrorJustReturn: false)
        }
        
    }
    
    struct StepFive {
        
        let input = Input()
        var output = Output()
        
        struct Input {
            let semesterObserver = PublishRelay<String>()
            let lastSemesterScoreObserver = PublishRelay<String>()
            let addSemesterObserver = BehaviorRelay<Bool>(value: false)
        }
        
        struct Output {
            var buttonValid = BehaviorRelay<Bool>(value: true).asDriver(onErrorJustReturn: false)
        }
        
    }
    
    
    
    
    
}


extension ExtraSignUpViewModel {
    
    func switchButtonValid(_ step: SignUpStep) {
        
        switch step {
        case .step1:
            currentStep = .step1
            rootView.output.nextBtValid = Driver.combineLatest(stepOne.output.cityValue, stepOne.output.guValue, stepOne.output.dismissSpecialView) //여기서 스케문으로 나눌꺼임
                .map { $0 != "" && $1 != "" && $2 != "특별사항 선택"}
                .asDriver(onErrorJustReturn: false)
        case .step2:
            currentStep = .step2
            rootView.output.nextBtValid = BehaviorRelay<Bool>(value: true).asDriver(onErrorJustReturn: true).debug()
        
        case .step3:
            currentStep = .step3
            rootView.output.nextBtValid = stepThree.output.buttonValid
        case .step4:
            currentStep = .step4
            rootView.output.nextBtValid = BehaviorRelay<Bool>(value: true).asDriver(onErrorJustReturn: true)
        case .step5:
            currentStep = .step5
            rootView.output.nextBtValid = BehaviorRelay<Bool>(value: true).asDriver(onErrorJustReturn: true)
        
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
            .subscribe(onNext: { _ in
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
        
        stepOne.output.spcialNoneValue = stepOne.input.specialNoneValueObserver.map { _ in self.user.specialStatus.contains("none") }.asDriver(onErrorJustReturn: false)
        
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
        
        stepOne.output.specialBtValid = Observable.of(stepOne.input.specialNoneValueObserver, stepOne.input.specialValueObserver).merge()
            .map { _ in self.user.specialStatus.count == 0 ? false : true }
            .asDriver(onErrorJustReturn: false)
        
        stepOne.output.dismissSpecialView = stepOne.input.specialButtonObserver.map({ _ in
            if self.user.specialStatus.count == 0 {
                return "특별사항 선택"
            } else if self.user.specialStatus.contains("none") {
                return "선택사항 없음"
            } else {
                return "선택사항 \(self.user.specialStatus.count)개"
            }
        }).asDriver(onErrorJustReturn: "")
        
        stepOne.output.nextBtValid = Driver.combineLatest(stepOne.output.cityValue, stepOne.output.guValue, stepOne.output.dismissSpecialView)
            .map { $0 != "" && $1 != "" && $2 != "특별사항 선택"}
            .asDriver(onErrorJustReturn: false)
    }
    
    func bindStepTwo() {
        
        stepTwo.input.incomeObserver.subscribe(onNext: {value in
            let income = Int(value) ?? 0
            print(income)
            incomeQuintile(income)
        }).disposed(by: disposeBag)
        
        stepTwo.input.employObserver.subscribe(onNext: {value in
            if value == "전체" {
                if self.user.employmentState.contains(value) {
                    self.user.employmentState = []
                } else {
                    self.user.employmentState = [value]
                }
            } else {
                if self.user.employmentState == ["전체"] {
                    self.user.employmentState = [value]
                } else if self.user.employmentState.contains(value) {
                    let index = self.user.employmentState.firstIndex(of: value) ?? 0
                    self.user.employmentState.remove(at: index)
                } else {
                    self.user.employmentState.append(value)
                }
            }
        }).disposed(by: disposeBag)
        
        
        stepTwo.output.buttonValid = Observable.combineLatest(stepTwo.input.employObserver, stepTwo.input.incomeObserver)
            .map { $0 != "" && $1 != "" }
            .asDriver(onErrorJustReturn: false)
        
        
        func incomeQuintile(_ value: Int) {
            if value <= 1462887 {
                self.user.incomeLevel = "1분위"
                self.user.incomeAvg = "30%"
            } else if value <= 2438145 {
                self.user.incomeLevel = "2분위"
                self.user.incomeAvg = "50%"
            } else if value <= 3413403 {
                self.user.incomeLevel = "3분위"
                self.user.incomeAvg = "70%"
            } else if value <= 4388661 {
                self.user.incomeLevel = "4분위"
                self.user.incomeAvg = "90%"
            } else if value <= 4876290 {
                self.user.incomeLevel = "5분위"
                self.user.incomeAvg = "100%"
            } else if value <= 6339177 {
                self.user.incomeLevel = "6분위"
                self.user.incomeAvg = "130%"
            } else if value <= 7314435 {
                self.user.incomeLevel = "7분위"
                self.user.incomeAvg = "150%"
            } else if value <= 9752580 {
                self.user.incomeLevel = "8분위"
                self.user.incomeAvg = "200%"
            } else if value <= 14628870 {
                self.user.incomeLevel = "9분위"
                self.user.incomeAvg = "300%"
            } else {
                self.user.incomeLevel = "10분위"
                self.user.incomeAvg = "-"
            }
        }
    }
    
    func bindStepThree() {
        stepThree.input.recordsObserver
            .subscribe(onNext: { value in
                if value == "전체" {
                    if self.user.schollRecords.contains(value) {
                        self.user.schollRecords = []
                    } else {
                        self.user.schollRecords = [value]
                    }
                } else {
                    if self.user.schollRecords == ["전체"] {
                        self.user.schollRecords = [value]
                    } else if self.user.schollRecords.contains(value) {
                        let index = self.user.schollRecords.firstIndex(of: value) ?? 0
                        self.user.schollRecords.remove(at: index)
                    } else {
                        self.user.schollRecords.append(value)
                    }
                }
            }).disposed(by: disposeBag)
        
        stepThree.output.buttonValid = stepThree.input.recordsObserver.map { _ in
            self.user.schollRecords.count != 0
        }.asDriver(onErrorJustReturn: false)
    }
    
    func bindStepFour() {
        
        stepFour.input.mainMajorObserver.subscribe(onNext: { valid in
            if valid == self.user.mainMajor {
                self.user.mainMajor = ""
            } else {
                self.user.mainMajor = valid
            }
        }).disposed(by: disposeBag)
        
        stepFour.input.subMajorObserver.subscribe(onNext: {valid in
            self.user.subMajor = valid
        }).disposed(by: disposeBag)
        
    }
    
    func bindStepFive() {
        
        stepFive.input.semesterObserver
            .subscribe(onNext: { value in
                self.user.semester = value
            }).disposed(by: disposeBag)
        
        stepFive.input.lastSemesterScoreObserver
            .subscribe(onNext: { value in
                if self.user.lastSemesterScore == value {
                    self.user.lastSemesterScore = ""
                } else {
                    self.user.lastSemesterScore = value
                }
            }).disposed(by: disposeBag)
        
        
    }
    
    func bindRootView() {
        rootView.output.nextBtValid = Driver.of(stepOne.output.nextBtValid, stepTwo.output.buttonValid, stepThree.output.buttonValid, stepFour.output.buttonValid, stepFive.output.buttonValid).merge()
            .map { _ in
                var nextValue = false
                switch self.currentStep {
                case .step1:
                    self.stepOne.output.nextBtValid.drive(onNext: {value in
                        nextValue = value
                    }).disposed(by: self.disposeBag)
                case .step2:
                    self.stepTwo.output.buttonValid.drive(onNext: { value in
                        nextValue = value
                    }).disposed(by: self.disposeBag)
                case .step3:
                    self.stepThree.output.buttonValid.drive(onNext: { value in
                        nextValue = value
                    }).disposed(by: self.disposeBag)
                case .step4:
                    nextValue = true
                case .step5:
                    nextValue = true
                    
                }
                return nextValue
            }.asDriver(onErrorJustReturn: false)
            
        
        rootView.output.goSignUp = rootView.input.nextBt.asSignal()
    
    }
    
}
