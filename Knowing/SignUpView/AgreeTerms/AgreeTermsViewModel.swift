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
        var allValid = PublishRelay<[Bool]>().asDriver(onErrorJustReturn: [])
        var firstValid = PublishRelay<[Bool]>().asDriver(onErrorJustReturn: [])
        var secondValid = PublishRelay<[Bool]>().asDriver(onErrorJustReturn: [])
        var thirdValid = PublishRelay<[Bool]>().asDriver(onErrorJustReturn: [])
        var nextBtValid = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
    }
    
    
    
    init() {
        
        
        input.allObserver.subscribe(onNext: {
            if self.checkBox[0] {
                self.checkBox = [false, false, false, false]
            } else {
                self.checkBox = [true, true, true, true]
            }
        }).disposed(by: disposeBag)
        
        output.allValid = input.allObserver.map { self.checkBox }.asDriver(onErrorJustReturn: [])
        
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
        
        output.firstValid = input.firstObserver.map { self.checkBox }.asDriver(onErrorJustReturn: [])
        
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
        
        output.secondValid = input.secondObserver.map { self.checkBox }.asDriver(onErrorJustReturn: [])
        
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
        
        output.thirdValid = input.thirdObserver.map { self.checkBox }.asDriver(onErrorJustReturn: [])
        
        output.nextBtValid = Observable.combineLatest(input.allObserver, input.firstObserver, input.secondObserver, input.thirdObserver).map({ _, _, _, _ in
            if self.checkBox[1] && self.checkBox[2] {
                return true
            } else {
                return false
            }
        }).asDriver(onErrorJustReturn: false)
        
    }
    
}
