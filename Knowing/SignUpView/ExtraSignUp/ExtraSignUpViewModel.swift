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
    var currentStep = SignUpStep.step1
    
    
    init() {
        
        bindStepOne()
        
        
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
}
