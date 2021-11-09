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
        
        
        
        // Step1
        stepOne.input.cityObserver
            .bind(to: self.stepOne.output.goCityView)
            .disposed(by: disposeBag)
        stepOne.output.goGuView = stepOne.input.guObserver.asDriver(onErrorJustReturn: "시/도 선택")
        stepOne.output.cityValue = stepOne.input.cityValueObserver.asDriver(onErrorJustReturn: "")
        stepOne.output.guValue = stepOne.input.guValueObserver.asDriver(onErrorJustReturn: "")
        
        rootView.output.nextBtValid = Driver.combineLatest(stepOne.output.cityValue, stepOne.output.guValue) //여기서 스케문으로 나눌꺼임
            .map { $0 != "" && $1 != "" }
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
        }
        
        struct Output {
            let goCityView = PublishRelay<Void>()
            var goGuView = PublishRelay<String>().asDriver(onErrorJustReturn: "시/도 선택")
            var cityValue:Driver<String> = PublishRelay<String>().asDriver(onErrorJustReturn: "")
            var guValue:Driver<String> = PublishRelay<String>().asDriver(onErrorJustReturn: "")
        }
        
    }
}
