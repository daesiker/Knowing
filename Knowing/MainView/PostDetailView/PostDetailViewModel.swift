//
//  PostDetailViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/25.
//

import Foundation
import RxSwift
import RxCocoa

class PostDetailViewModel {
    
    let disposeBag = DisposeBag()
    let input = Input()
    var output = Output()
    
    var scrollOffset = [true, false, false, false]
    
    struct Input {
        let contentsObserver = PublishRelay<Void>()
        let conditionObserver = PublishRelay<Void>()
        let methodObserver = PublishRelay<Void>()
        let etcObserver = PublishRelay<Void>()
    }
    
    struct Output {
        var contentsValue = PublishRelay<[Bool]>().asDriver(onErrorJustReturn: [true, false, false, false])
        var conditionValue = PublishRelay<[Bool]>().asDriver(onErrorJustReturn: [true, false, false, false])
        var methodValue = PublishRelay<[Bool]>().asDriver(onErrorJustReturn: [true, false, false, false])
        var etcValue = PublishRelay<[Bool]>().asDriver(onErrorJustReturn: [true, false, false, false])
    }
    
    init() {
        
        output.contentsValue = input.contentsObserver
            .map { [true, false, false, false] }.asDriver(onErrorJustReturn: [true, false, false, false])
        
        output.conditionValue = input.conditionObserver.map { [false, true, false, false] }.asDriver(onErrorJustReturn: [false, true, false, false] )
        
        output.methodValue = input.methodObserver.map {[false, false, true, false]}.asDriver(onErrorJustReturn: [false, false, true, false])
        
        output.etcValue = input.etcObserver.map {[false, false, false, true]}.asDriver(onErrorJustReturn: [false, false, false, true])
        
        
    }
    
}
