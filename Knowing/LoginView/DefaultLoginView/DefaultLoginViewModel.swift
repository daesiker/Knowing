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
import RxRelay

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
        var loginValid:Driver<Bool> = BehaviorRelay<Bool>(value: false).asDriver(onErrorJustReturn: false)
        var doLogin = PublishRelay<String>()
        var doError = PublishRelay<KnowingError>()
    }
    
    init() {
        
        input.loginObserver.withLatestFrom(Observable.combineLatest(input.emailObserver, input.pwObserver)).debug()
            .flatMapLatest(self.doLogin).debug()
            .subscribe({ event in
                
                switch event {
                case .error(_):
                    break
                case .next(let value):
                    let user = value.components(separatedBy: " ")
                    Auth.auth().signIn(withEmail: user[0], password: user[1]) { auth, error in
                        if let error = error {
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
                        } else {
                            self.output.doLogin.accept("성공")
                        }
                    }
                case .completed:
                    break
                }
            }).disposed(by: disposeBag)
        
        output.emailValid = input.emailObserver
            .map { !$0.isEmpty && $0.contains(".") && $0.contains("@") }
            .asDriver(onErrorJustReturn: false)
        
        output.pwValid = input.pwObserver
            .map { $0.validpassword() }
            .asDriver(onErrorJustReturn: false)
        
        output.loginValid = Driver.combineLatest(output.emailValid, output.pwValid)
            .map { $0 && $1 }
            .asDriver(onErrorJustReturn: false)
        
    }
    
    func doLogin(_ email: String, pwd: String) -> Observable<String> {
        
        return Observable.create { observe in
            
            
            observe.onNext("\(email) \(pwd)")
            
            return Disposables.create()
        }
    }
    
}
