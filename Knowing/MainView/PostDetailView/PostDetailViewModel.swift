//
//  PostDetailViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON
import Firebase

class PostDetailViewModel {
    
    let main = MainTabViewModel.instance
    let post:Post
    let disposeBag = DisposeBag()
    let input = Input()
    var output = Output()
    
    
    var scrollOffset = [true, false, false, false]
    
    struct Input {
        let contentsObserver = PublishRelay<Void>()
        let conditionObserver = PublishRelay<Void>()
        let methodObserver = PublishRelay<Void>()
        let etcObserver = PublishRelay<Void>()
        let bookmarkObserver = PublishRelay<String>()
    }
    
    struct Output {
        var contentsValue = PublishRelay<[Bool]>().asDriver(onErrorJustReturn: [true, false, false, false])
        var conditionValue = PublishRelay<[Bool]>().asDriver(onErrorJustReturn: [true, false, false, false])
        var methodValue = PublishRelay<[Bool]>().asDriver(onErrorJustReturn: [true, false, false, false])
        var etcValue = PublishRelay<[Bool]>().asDriver(onErrorJustReturn: [true, false, false, false])
        
        var bookmarkEnable = PublishRelay<Bool>()
        var errorValid = PublishRelay<Error>()
        
        
    }
    
    init(_ post: Post) {
        self.post = post
        
        output.contentsValue = input.contentsObserver
            .map { [true, false, false, false] }.asDriver(onErrorJustReturn: [true, false, false, false])
        
        output.conditionValue = input.conditionObserver.map { [false, true, false, false] }.asDriver(onErrorJustReturn: [false, true, false, false] )
        
        output.methodValue = input.methodObserver.map {[false, false, true, false]}.asDriver(onErrorJustReturn: [false, false, true, false])
        
        output.etcValue = input.etcObserver.map {[false, false, false, true]}.asDriver(onErrorJustReturn: [false, false, false, true])
        
        input.bookmarkObserver.subscribe(onNext: {value in
            let uid = Auth.auth().currentUser!.uid
            let url = "https://www.makeus-hyun.shop/app/users/bookmark"
            let header:HTTPHeaders = ["userUid": uid,
                                      "welfareUid": self.post.uid]
            
            AF.request(url, method: .post, headers: header)
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        if self.main.user.bookmark.contains(value) {
                            let index = self.main.user.bookmark.firstIndex(of: value)
                            self.main.user.bookmark.remove(at: index!)
                            self.output.bookmarkEnable.accept(false)
                        } else {
                            self.main.user.bookmark.append(value)
                            self.output.bookmarkEnable.accept(true)
                        }
                    case .failure(let error):
                        self.output.errorValid.accept(error)
                    }
                }
        }).disposed(by: disposeBag)
        
       
    }
    
}
