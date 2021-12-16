//
//  HomeAllPostViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/29.
//

import Foundation
import RxSwift
import RxCocoa

class HomeAllPostViewModel {
    
    let main = MainTabViewModel.instance
    let disposeBag = DisposeBag()
    var posts:[Post] = []
    var category:String = "학생 지원"
    let input = Input()
    var output = Output()
    
    struct Input {
        let categoryObserver = PublishRelay<String>()
        
    }
    
    struct Output {
        var postChanged = PublishRelay<Int>().asDriver(onErrorJustReturn: 0)
        
    }
    
    init() {
        
        posts = main.posts["allstudentCategory"] ?? []
        
        input.categoryObserver.subscribe(onNext: {value in
            self.category = value
            switch value {
            case "학생 지원":
                self.posts = self.main.posts["allstudentCategory"]!
            case "취업 지원":
                self.posts = self.main.posts["allemployCategory"]!
            case "창업 지원":
                self.posts = self.main.posts["allfoundationCategory"]!
            case "주거 · 금융 지원":
                self.posts = self.main.posts["allresidentCategory"]!
            case "생활 · 복지 지원":
                self.posts = self.main.posts["alllifeCategory"]!
            default:
                self.posts = self.main.posts["allmedicalCategory"]!
            }
        }).disposed(by: disposeBag)
        
        output.postChanged = input.categoryObserver.map { _ in
            return self.posts.count }.asDriver(onErrorJustReturn: 0)
        
    }
    
    
}
