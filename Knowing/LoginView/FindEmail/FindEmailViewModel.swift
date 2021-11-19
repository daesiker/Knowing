//
//  FindEmailViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/10.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class FindEmailViewModel {
    
    let disposeBag = DisposeBag()
    let input = Input()
    var output = Output()
    
    struct Input {
        let nameObserver = PublishRelay<String>()
        let phoneObserver = PublishRelay<String>()
        let buttonObserver = PublishRelay<Void>()
    }
    
    struct Output {
        var btValid = BehaviorRelay<Bool>(value: false).asDriver(onErrorJustReturn: false)
        var nameValue = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var phoneValue = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var findEmail:Signal<String> = PublishRelay<String>().asSignal()
        var error:Signal<Error> = PublishRelay<Error>().asSignal()
    }
    
    init() {
        let findEmail = PublishRelay<String>()
        let errorRelay = PublishRelay<Error>()
        
        output.nameValue = input.nameObserver.map{ $0.count >= 2 }.asDriver(onErrorJustReturn: false)
        output.phoneValue = input.phoneObserver.map {$0.count >= 7 }.asDriver(onErrorJustReturn: false)
        
        output.btValid = Driver.combineLatest(output.nameValue, output.phoneValue)
            .map { $0 && $1 }
            .asDriver(onErrorJustReturn: false)
        
        input.buttonObserver.withLatestFrom(Observable.combineLatest(input.nameObserver, input.phoneObserver)).flatMap(self.findEmail).subscribe({ event in
            switch event {
            case .error(let error):
                errorRelay.accept(error)
            case .next(let value):
                findEmail.accept(value)
            case .completed:
                break
            }
        }).disposed(by: disposeBag)
        
        output.findEmail = findEmail.asSignal()
        output.error = errorRelay.asSignal()
    }
    
    func findEmail(_ name:String, phone: String) -> Observable<String> {
        
        return Observable.create { valid in
         let url = "https://www.makeus-hyun.shop/app/users/findId"
            let parameter:Parameters = ["name": name,
                                        "phNum": phone]
            AF.request(url, method: .get, parameters: parameter, encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let result = json["result"].dictionaryObject
                        if let result = result?["email"] as? String {
                            valid.onNext(result)
                        }
                    case .failure(let error):
                        valid.onError(error)
                    }
                    
                }
            return Disposables.create()
        }
    }
    
    
}

