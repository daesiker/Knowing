//
//  SignUpViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/02.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel {
   
    let disposeBag = DisposeBag()
    let input = Input()
    var output = Output()
    
    
    
    struct Input {
        let nameObserver = BehaviorRelay<String>(value: "")
        let emailObserver = BehaviorRelay<String>(value: "")
        let pwObserver = BehaviorRelay<String>(value: "")
        let maleObserver = PublishRelay<String>()
        let femaleObserver = PublishRelay<String>()
        let birthObserver = BehaviorRelay<String>(value: "")
    }
    
    struct Output {
        var nameValid:Driver<Bool> = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var emailValid:Driver<Bool> = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        
        
        
    }
    
    init() {
        output.nameValid = input.nameObserver
            .map{ $0.count > 3 }
            .asDriver(onErrorJustReturn: false)
        
        output.emailValid = input.emailObserver
            .map{ $0.count > 3 }
            .asDriver(onErrorJustReturn: false)
        
        
    }
    
    
}
