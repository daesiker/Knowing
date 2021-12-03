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
        var doLogin = PublishRelay<Void>()
        var doError = PublishRelay<KnowingError>()
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
        
        
        input.loginObserver.withLatestFrom(Observable.combineLatest(input.emailObserver, input.pwObserver))
            .flatMap(doLogin)
            .subscribe({ event in
                switch event {
                case .completed:
                    break
                case .error(let error):
                    let errCode = AuthErrorCode(rawValue: error._code)
                    var errMsg = ""
                    switch errCode {
                    case .userNotFound:
                        errMsg = "가입되어 있지 않은 이메일입니다."
                    case .emailAlreadyInUse:
                        errMsg = "가입되어 있지 않은 이메일입니다."
                    case .invalidEmail:
                        errMsg = "유효하지 않은 이메일입니다."
                    case .wrongPassword:
                        errMsg = "잘못된 패스워드입니다."
                    default:
                        errMsg = "네트워크 연결 상태를 확인해주세요."
                    }
                    let knowingError = KnowingError(code: 103, msg: errMsg)
                    self.output.doError.accept(knowingError)
                case .next(_):
                    self.output.doLogin.accept(())
                }
            }).disposed(by: disposeBag)
        
    }
    
    func doLogin(_ email: String, pwd: String) -> Observable<Void> {
        
        Observable.create { observe in
            Auth.auth().signIn(withEmail: email, password: pwd) { auth, error in
                if let error = error {
                    observe.onError(error)
                    return
                }
                observe.onNext(())
            }
            return Disposables.create()
        }
    }
    
}
