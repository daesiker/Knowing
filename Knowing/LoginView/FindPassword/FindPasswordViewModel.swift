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
        var findPassword:Signal<Void> = PublishRelay<Void>().asSignal()
        var errorRelay:Signal<Error> = PublishRelay<Error>().asSignal()
    }
    
    init() {
        
        let findPassword = PublishRelay<Void>()
        let errorRelay = PublishRelay<Error>()
        
        output.btValid = Driver.combineLatest(input.nameObserver.asDriver(onErrorJustReturn: ""), input.emailObserver.asDriver(onErrorJustReturn: ""))
            .map { $0 != "" && $1 != "" }
            .asDriver(onErrorJustReturn: false)
        
        input.buttonObserver
            .withLatestFrom(input.emailObserver)
            .flatMap(self.findPwd)
            .subscribe({ event in
                switch event {
                case .error(let error):
                    errorRelay.accept(error)
                case .next(_):
                    findPassword.accept(())
                default:
                    break
                }
            }).disposed(by: disposeBag)
        
        output.errorRelay = errorRelay.asSignal()
        output.findPassword = findPassword.asSignal()
        
        
    }
    
    func findPwd(_ string: String) -> Observable<Void> {
        
        return Observable.create { observer in
            Auth.auth().sendPasswordReset(withEmail: string) { error in
                if let error = error {
                    print("에러")
                    observer.onError(error)
                } else {
                    print("호출")
                    observer.onNext(())
                }
            }
            return Disposables.create()
        }
    }
    
}
