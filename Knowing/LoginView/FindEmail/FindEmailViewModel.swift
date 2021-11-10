//
//  FindEmailViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/10.
//

import Foundation
import RxSwift
import RxCocoa

class FindEmailViewModel {
    
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
        var findEmail:Signal<Void> = PublishRelay<Void>().asSignal()
        var error:Signal<Error> = PublishRelay<Error>().asSignal()
    }
    
    init() {
        output.btValid = Driver.combineLatest(input.nameObserver.asDriver(onErrorJustReturn: ""), input.phoneObserver.asDriver(onErrorJustReturn: ""))
            .map { $0 != "" && $1 != "" }
            .asDriver(onErrorJustReturn: false)
        
        
    }
    
    
}
