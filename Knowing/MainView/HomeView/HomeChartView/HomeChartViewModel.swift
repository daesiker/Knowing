//
//  HomeChartViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/29.
//

import Foundation
import RxCocoa
import RxSwift

class HomeChartViewModel {
    
    static let instance = HomeChartViewModel()
    
    let disposeBag = DisposeBag()
    let main = MainTabViewModel.instance
    let input = Input()
    var output = Output()
    var category = "학생 지원"
    var posts:[Post] = []
    
    struct Input {
        let categoryObserver = PublishRelay<String>()
        let postObserver = PublishRelay<Post>()
    }
    
    struct Output {
        var postChanged = PublishRelay<[Post]>().asDriver(onErrorJustReturn: [])
        var getPost = PublishRelay<Post>().asDriver(onErrorJustReturn: Post())
    }
    
    init() {
        
        posts = main.posts["studentCategory"] ?? []
        
        input.categoryObserver.subscribe(onNext: {value in
            self.category = value
            switch value {
            case "학생 지원":
                self.posts = self.main.posts["studentCategory"]!
            case "취업 지원":
                self.posts = self.main.posts["employCategory"]!
            case "창업 지원":
                self.posts = self.main.posts["foundationCategory"]!
            case "주거 · 금융 지원":
                self.posts = self.main.posts["residentCategory"]!
            case "생활 · 복지 지원":
                self.posts = self.main.posts["lifeCategory"]!
            default:
                self.posts = self.main.posts["covidCategory"]!
            }
            print(self.posts)
        }).disposed(by: disposeBag)
        
        output.getPost = input.postObserver.asDriver(onErrorJustReturn: Post())
        
        output.postChanged = input.categoryObserver.map { _ in
            return self.posts}.asDriver(onErrorJustReturn: [])
        
    }
    
}
