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
    //contentsBt conditionBt methodBt etcBt
    
    let input = Input()
    
    struct Input {
        let contentsObserver = PublishRelay<Bool>()
        let conditionObserver = PublishRelay<Bool>()
        let methodObserver = PublishRelay<Bool>()
        let etcObserver = PublishRelay<Bool>()
    }
    
    
}
