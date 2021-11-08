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
    var user = User()
    
    
    
    struct Input {
        let nameObserver = PublishRelay<String>()
        let emailObserver = PublishRelay<String>()
        let pwObserver = PublishRelay<String>()
        let genderObserver = PublishRelay<Gender>()
        let birthObserver = PublishRelay<String>()
        let signUpObserver = PublishRelay<Bool>()
        
    }
    
    struct Output {
        var emailValid:Driver<Bool> = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var pwValid:Driver<Bool> = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var genderValid:Driver<Gender> = PublishRelay<Gender>().asDriver(onErrorJustReturn: .notSelected)
        var buttonValid:Driver<Bool> = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        
    }
    
    init() {
        input.nameObserver.subscribe(onNext: {valid in
            self.user.name = valid
        }).disposed(by: disposeBag)
        
        input.emailObserver.subscribe(onNext: {valid in
            self.user.email = valid
        }).disposed(by: disposeBag)
        
        input.pwObserver.subscribe(onNext: {valid in
            self.user.password = valid
        }).disposed(by: disposeBag)
        
        input.genderObserver.subscribe(onNext: {valid in
            switch valid {
            case .male:
                self.user.gender = "male"
            case .female:
                self.user.gender = "female"
            case .notSelected:
                break
            }
        }).disposed(by: disposeBag)
        
        input.birthObserver.subscribe(onNext: {valid in
            self.user.birth = valid
            print(self.user)
        }).disposed(by: disposeBag)
        
        
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
        
        output.genderValid = input.genderObserver.asDriver(onErrorJustReturn: .notSelected)
        
        output.buttonValid = Driver.combineLatest(output.emailValid, output.pwValid, input.nameObserver.asDriver(onErrorJustReturn: ""), input.genderObserver.asDriver(onErrorJustReturn: .notSelected), input.birthObserver.asDriver(onErrorJustReturn: ""))
            .map { $0  && $1 && $2 != "" && $3 != .notSelected && $4 != "" }
            .asDriver(onErrorJustReturn: false)
        
        
    }
    
    
}
