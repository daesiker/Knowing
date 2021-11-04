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
    
    let disposeBag = DisposeBag()
    let stepOne = StepOne()
    
    init() {
        
        stepOne.input.cityObserver
            .bind(to: self.stepOne.output.goCityView)
            .disposed(by: disposeBag)
        
        
        
    }
    
    
    
}

extension ExtraSignUpViewModel {
    struct StepOne {
        
        let input = Input()
        let output = Output()
        struct Input {
            let cityObserver = PublishRelay<Void>()
            let guObserver = PublishRelay<Void>()
        }
        
        struct Output {
            let goCityView = PublishRelay<Void>()
            let goGuView = PublishRelay<String>().asDriver(onErrorJustReturn: "")
        }
        
    }
}
