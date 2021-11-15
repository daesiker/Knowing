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
        var nameValue = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var phoneValue = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var findEmail:Signal<Void> = PublishRelay<Void>().asSignal()
        var error:Signal<Error> = PublishRelay<Error>().asSignal()
    }
    
    init() {
        
        output.nameValue = input.nameObserver.map{ $0.count >= 2 }.asDriver(onErrorJustReturn: false)
        output.phoneValue = input.phoneObserver.map {$0.count >= 7 }.asDriver(onErrorJustReturn: false)
        
        output.btValid = Driver.combineLatest(output.nameValue, output.phoneValue)
            .map { $0 && $1 }
            .asDriver(onErrorJustReturn: false)
    }
    
    
}

