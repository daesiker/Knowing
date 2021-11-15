//
//  ApiSignUpViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/15.
//

import Foundation
import RxSwift
import RxCocoa

class ApiSignUpViewModel {
    
    let disposeBag = DisposeBag()
    var user = User()
    let input = Input()
    var output = Output()
    
    struct Input {
        let nameObserver = PublishRelay<String>()
        let genderObserver = PublishRelay<Gender>()
        let birthObserver = PublishRelay<String>()
        let signUpObserver = PublishRelay<Void>()
    }
    
    struct Output {
        var genderValid:Driver<Gender> = PublishRelay<Gender>().asDriver(onErrorJustReturn: .notSelected)
        var buttonValid:Driver<Bool> = BehaviorRelay<Bool>(value: false).asDriver(onErrorJustReturn: false)
        var signUpValue = PublishRelay<User>()
    }
    
    init() {
        input.nameObserver.subscribe(onNext: {valid in
            self.user.name = valid
        }).disposed(by: disposeBag)
        
        input.genderObserver.subscribe(onNext: {valid in
            switch valid {
            case .male:
                self.user.gender = true
            case .female:
                self.user.gender = false
            case .notSelected:
                break
            }
        }).disposed(by: disposeBag)
        
        input.birthObserver.subscribe(onNext: {valid in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            
            let date = dateFormatter.date(from: valid)
            
            self.user.birth = date?.age ?? 0
        }).disposed(by: disposeBag)
        
        input.signUpObserver
            .map { self.user }
            .bind(to: output.signUpValue)
            .disposed(by: disposeBag)
        
        output.genderValid = input.genderObserver.asDriver(onErrorJustReturn: .notSelected)
        
        
        output.buttonValid = Observable.combineLatest(input.nameObserver, input.genderObserver, input.birthObserver)
            .map { $0 != "" && $1 != .notSelected && $2 != "" }
            .asDriver(onErrorJustReturn: false)
    }
    
    
}
