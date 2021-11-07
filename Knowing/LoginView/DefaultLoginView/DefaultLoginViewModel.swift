//
//  DefaultLoginViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/07.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

class DefaultLoginViewModel {
    
    let user = User()
    let disposeBag = DisposeBag()
    
    let input = Input()
    var output = Output()
    
    struct Input {
        let emailObserver = PublishRelay<String>()
        let pwObserver = PublishRelay<String>()
        let loginObserver = PublishRelay<Void>()
    }
    
    struct Output {
        var emailValid:Driver<Bool> = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var pwValid:Driver<Bool> = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var loginValid:Driver<Bool> = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
    }
    
    init() {
        output.emailValid = input.emailObserver
            .map ({ valid in
                if !(!valid.isEmpty && valid.contains(".") && valid.contains("@")) {
                    return false
                } else {
                    return true
                }
            })
            .asDriver(onErrorJustReturn: false)
        
        output.pwValid = input.pwObserver
            .map { $0.validpassword() }
            .asDriver(onErrorJustReturn: false)
        
        output.loginValid = Driver.combineLatest(output.emailValid, output.pwValid)
            .map { $0 && $1 }
            .asDriver(onErrorJustReturn: false)
        
        
    }
    
}
