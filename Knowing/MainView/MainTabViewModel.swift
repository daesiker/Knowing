//
//  MainTabViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/29.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class MainTabViewModel {
    
    static let instance = MainTabViewModel()
    
    var user = User()
    var posts:[String: [Post]] = [:]
    var bookmarks:[Post] = []
    let disposeBag = DisposeBag()
    let bcObserver = PublishRelay<UIColor>()
    var bcOutput = PublishRelay<UIColor>().asDriver(onErrorJustReturn: .white)
    var sortType = SortType.maxMoney
    let input = Input()
    let output = Output()
    
    struct Input {
        let sortObserver = PublishRelay<SortType>()
    }
    
    struct Output {
        let sortValue = PublishRelay<SortType>()
    }
    
    
    init() {
        
        bcOutput = bcObserver.asDriver(onErrorJustReturn: .white)
        
        input.sortObserver.subscribe(onNext: { value in
            self.sortType = value
            self.output.sortValue.accept(value)
        }).disposed(by: disposeBag)
        
        
    }
    
    func clear() {
        user = User()
        posts = [:]
        bookmarks = []
    }
    
}
