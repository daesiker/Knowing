//
//  FindPasswordViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/10.
//

import Foundation
import RxCocoa
import RxSwift
import Firebase

class FindPasswordViewModel {
    
    let disposeBag = DisposeBag()
    let input = Input()
    var output = Output()
    
    struct Input {
        let nameObserver = PublishRelay<String>()
        let emailObserver = PublishRelay<String>()
        let buttonObserver = PublishRelay<Void>()
    }
    
    struct Output {
        var btValid = BehaviorRelay<Bool>(value: false).asDriver(onErrorJustReturn: false)
        var findPassword = PublishRelay<Bool>()
        var errorRelay = PublishRelay<KnowingError>()
    }
    
    init() {
        output.btValid = Driver.combineLatest(input.nameObserver.asDriver(onErrorJustReturn: ""), input.emailObserver.asDriver(onErrorJustReturn: ""))
            .map { $0 != "" && $1 != "" }
            .asDriver(onErrorJustReturn: false)
        
        input.buttonObserver.withLatestFrom(input.emailObserver)
            //.flatMap(input.emailObserver)
            .subscribe(onNext: { value in
                Auth.auth().sendPasswordReset(withEmail: value) { error in
                    if let error = error {
                        let errCode = AuthErrorCode(rawValue: error._code)
                        var errMsg = ""
                        switch errCode {
                        case .userNotFound:
                            errMsg = "가입되어 있지 않은 이메일입니다."
                        default:
                            errMsg = "네트워크 연결 상태를 확인해주세요."
                        }
                        let knowingError = KnowingError(code: 103, msg: errMsg)
                        self.output.errorRelay.accept(knowingError)
                    } else {
                        self.output.findPassword.accept(true)
                    }
                }
                
            }).disposed(by: disposeBag)
        
        
    }
    
    func findPwd(_ string: String) -> Observable<String> {
        
        return Observable.create { observer in
            observer.onNext(string)
            return Disposables.create()
        }
    }
    
}
