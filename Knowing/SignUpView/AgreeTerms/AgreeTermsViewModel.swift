//
//  AgreeTermsViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/14.
//

import Foundation
import RxSwift
import RxCocoa

class AgreeTermsViewModel {
    
    let disposeBag = DisposeBag()
    let input = Input()
    var output = Output()
    
    var checkBox:[Bool] = [false, false, false, false]
    
    struct Input {
        let allObserver = PublishRelay<Void>()
        let firstObserver = PublishRelay<Void>()
        let secondObserver = PublishRelay<Void>()
        let thirdObserver = PublishRelay<Void>()
        let nextBtObserver = PublishRelay<Void>()
    }
    
    struct Output {
        var allValid = BehaviorRelay<[Bool]>(value: [false, false, false, false]).asDriver(onErrorJustReturn: [])
        var firstValid = BehaviorRelay<[Bool]>(value: [false, false, false, false]).asDriver(onErrorJustReturn: [])
        var secondValid = BehaviorRelay<[Bool]>(value: [false, false, false, false]).asDriver(onErrorJustReturn: [])
        var thirdValid = BehaviorRelay<[Bool]>(value: [false, false, false, false]).asDriver(onErrorJustReturn: [])
        var nextBtValid = BehaviorRelay<Bool>(value: false).asDriver(onErrorJustReturn: false)
    }
    
    
    
    init() {
        output.firstValid = input.firstObserver.map { self.checkBox }.asDriver(onErrorJustReturn: [])
        output.secondValid = input.secondObserver.map { self.checkBox }.asDriver(onErrorJustReturn: [])
        output.thirdValid = input.thirdObserver.map { self.checkBox }.asDriver(onErrorJustReturn: [])
        output.allValid = input.allObserver.map { self.checkBox }.asDriver(onErrorJustReturn: [])
        
        
        
        input.allObserver.subscribe(onNext: {
            if self.checkBox[0] {
                self.checkBox = [false, false, false, false]
            } else {
                self.checkBox = [true, true, true, true]
            }
        }).disposed(by: disposeBag)
        
        
        
        input.firstObserver.subscribe(onNext: {
            if self.checkBox[1] {
                if self.checkBox[0] {
                    self.checkBox[0] = false
                }
                self.checkBox[1] = false
            } else {
                if self.checkBox[2] && self.checkBox[3] {
                    self.checkBox[0] = true
                }
                self.checkBox[1] = true
            }
        }).disposed(by: disposeBag)
        
        
        input.secondObserver.subscribe(onNext: {
            if self.checkBox[2] {
                if self.checkBox[0] {
                    self.checkBox[0] = false
                }
                self.checkBox[2] = false
            } else {
                if self.checkBox[1] && self.checkBox[3] {
                    self.checkBox[0] = true
                }
                self.checkBox[2] = true
            }
        }).disposed(by: disposeBag)
        
        
        
        input.thirdObserver.subscribe(onNext: {
            if self.checkBox[3] {
                if self.checkBox[0] {
                    self.checkBox[0] = false
                }
                self.checkBox[3] = false
            } else {
                if self.checkBox[1] && self.checkBox[2] {
                    self.checkBox[0] = true
                }
                self.checkBox[3] = true
            }
        }).disposed(by: disposeBag)
        
        
        
        
        
        
    }
    
}
