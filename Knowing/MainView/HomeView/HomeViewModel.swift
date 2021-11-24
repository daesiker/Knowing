//
//  HomeViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/24.
//

import Foundation
import RxCocoa
import RxSwift

class HomeViewModel {
    
    static let instance = HomeViewModel()
    
    var section = PostSectionModel()
    var items = PublishRelay<[PostSectionModel]>()
    init() {
        section.items = [Post(), Post(), Post(), Post(), Post(), Post()]
        
        items.accept([section])
    }
    
    
}


extension HomeViewModel {
    
    struct CalendarBind {
        
        
       
        
    }
    
    
    
}
