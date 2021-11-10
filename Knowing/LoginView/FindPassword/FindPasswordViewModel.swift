//
//  FindPasswordViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/10.
//

import Foundation
import RxCocoa
import RxSwift

class FindPasswordViewModel {
    
    let disposeBag = DisposeBag()
    let input = Input()
    var output = Output()
    
    struct Input {
        let nameObserver = PublishRelay<String>()
        let phoneObserver = PublishRelay<String>()
        let buttonObserver = PublishRelay<Void>()
    }
    
    struct Output {
        var btValid = BehaviorRelay<Bool>(value: false).asDriver(onErrorJustReturn: false)
        var findPassword:Signal<Void> = PublishRelay<Void>().asSignal()
        var error:Signal<Error> = PublishRelay<Error>().asSignal()
    }
    
    init() {
        output.btValid = Driver.combineLatest(input.nameObserver.asDriver(onErrorJustReturn: ""), input.phoneObserver.asDriver(onErrorJustReturn: ""))
            .map { $0 != "" && $1 != "" }
            .asDriver(onErrorJustReturn: false)
    }
    
}
