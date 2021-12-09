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
    
    
    
    
    init() {
        
        bcOutput = bcObserver.asDriver(onErrorJustReturn: .white)
        
    }
    
    func clear() {
        user = User()
        posts = [:]
        bookmarks = []
    }
    
}
