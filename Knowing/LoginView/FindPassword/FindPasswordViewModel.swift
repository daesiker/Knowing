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
        var findPassword = PublishRelay<Void>()
        var errorRelay = PublishRelay<KnowingError>()
    }
    
    init() {
        
        output.btValid = Driver.combineLatest(input.nameObserver.asDriver(onErrorJustReturn: ""), input.emailObserver.asDriver(onErrorJustReturn: ""))
            .map { $0 != "" && $1 != "" }
            .asDriver(onErrorJustReturn: false)
        
        input.buttonObserver
            .withLatestFrom(input.emailObserver)
            .flatMap(self.findPwd)
            .subscribe({ event in
                switch event {
                case .error(let error):
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
                    
                case .next(_):
                    self.output.findPassword.accept(())
                default:
                    break
                }
            }).disposed(by: disposeBag)
        
        
    }
    
    func findPwd(_ string: String) -> Observable<Void> {
        
        return Observable.create { observer in
            Auth.auth().sendPasswordReset(withEmail: string) { error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(())
                }
            }
            return Disposables.create()
        }
    }
    
}
