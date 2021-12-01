//
//  AddPostCategoryViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/10.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase
import Alamofire
import SwiftyJSON

class AddPostCategoryViewModel {
    
    let disposeBag = DisposeBag()
    var user = User()
    let input = Input()
    var output = Output()
    let isModify:Bool
    
    struct Input {
        let studentObserver = PublishRelay<String>()
        let empolyObserver = PublishRelay<String>()
        let foundationObserver = PublishRelay<String>()
        let residentObserver = PublishRelay<String>()
        let lifeObserver = PublishRelay<String>()
        let covidObserver = PublishRelay<String>()
        let btObserver = PublishRelay<Void>()
        
    }
    
    struct Output {
        var buttonValid = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var goSignUp = PublishRelay<User>().asSignal()
        var error = PublishRelay<Error>().asSignal()
    }
    
    init(isModify: Bool = false) {
        self.isModify = isModify
        let signUpRelay = PublishRelay<User>()
        let errorRelay = PublishRelay<Error>()
        
        input.studentObserver.subscribe(onNext: { value in
            if value == "전체" {
                if self.user.studentCategory.contains(value) {
                    self.user.studentCategory = []
                } else {
                    self.user.studentCategory = [value]
                }
            } else {
                if self.user.studentCategory == ["전체"] {
                    self.user.studentCategory = [value]
                } else if self.user.studentCategory.contains(value) {
                    let index = self.user.studentCategory.firstIndex(of: value) ?? 0
                    self.user.studentCategory.remove(at: index)
                } else {
                    self.user.studentCategory.append(value)
                }
            }
        }).disposed(by: disposeBag)
        
        input.empolyObserver.subscribe(onNext: { value in
            if value == "전체" {
                if self.user.empolyCategory.contains(value) {
                    self.user.empolyCategory = []
                } else {
                    self.user.empolyCategory = [value]
                }
            } else {
                if self.user.empolyCategory == ["전체"] {
                    self.user.empolyCategory = [value]
                } else if self.user.empolyCategory.contains(value) {
                    let index = self.user.empolyCategory.firstIndex(of: value) ?? 0
                    self.user.empolyCategory.remove(at: index)
                } else {
                    self.user.empolyCategory.append(value)
                }
            }
        }).disposed(by: disposeBag)
        
        input.foundationObserver.subscribe(onNext: { value in
            if value == "전체" {
                if self.user.foundationCategory.contains(value) {
                    self.user.foundationCategory = []
                } else {
                    self.user.foundationCategory = [value]
                }
            } else {
                if self.user.foundationCategory == ["전체"] {
                    self.user.foundationCategory = [value]
                } else if self.user.foundationCategory.contains(value) {
                    let index = self.user.foundationCategory.firstIndex(of: value) ?? 0
                    self.user.foundationCategory.remove(at: index)
                } else {
                    self.user.foundationCategory.append(value)
                }
            }
        }).disposed(by: disposeBag)
        
        input.residentObserver.subscribe(onNext: { value in
            if value == "전체" {
                if self.user.residentCategory.contains(value) {
                    self.user.residentCategory = []
                } else {
                    self.user.residentCategory = [value]
                }
            } else {
                if self.user.residentCategory == ["전체"] {
                    self.user.residentCategory = [value]
                } else if self.user.residentCategory.contains(value) {
                    let index = self.user.residentCategory.firstIndex(of: value) ?? 0
                    self.user.residentCategory.remove(at: index)
                } else {
                    self.user.residentCategory.append(value)
                }
            }
        }).disposed(by: disposeBag)
        
        input.lifeObserver.subscribe(onNext: { value in
            if value == "전체" {
                if self.user.lifeCategory.contains(value) {
                    self.user.lifeCategory = []
                } else {
                    self.user.lifeCategory = [value]
                }
            } else {
                if self.user.lifeCategory == ["전체"] {
                    self.user.lifeCategory = [value]
                } else if self.user.lifeCategory.contains(value) {
                    let index = self.user.lifeCategory.firstIndex(of: value) ?? 0
                    self.user.lifeCategory.remove(at: index)
                } else {
                    self.user.lifeCategory.append(value)
                }
            }
        }).disposed(by: disposeBag)
        
        
        input.covidObserver.subscribe(onNext: { value in
            if value == "전체" {
                if self.user.covidCategory.contains(value) {
                    self.user.covidCategory = []
                } else {
                    self.user.covidCategory = [value]
                }
            } else {
                if self.user.covidCategory == ["전체"] {
                    self.user.covidCategory = [value]
                } else if self.user.covidCategory.contains(value) {
                    let index = self.user.covidCategory.firstIndex(of: value) ?? 0
                    self.user.covidCategory.remove(at: index)
                } else {
                    self.user.covidCategory.append(value)
                }
            }
        }).disposed(by: disposeBag)
        
        output.buttonValid = Observable.of(input.covidObserver, input.empolyObserver, input.foundationObserver, input.lifeObserver, input.residentObserver, input.studentObserver).merge().map { _ in
            if self.user.covidCategory.count == 0 && self.user.empolyCategory.count == 0 {
                if self.user.foundationCategory.count == 0 && self.user.lifeCategory.count == 0 {
                    if self.user.residentCategory.count == 0 && self.user.studentCategory.count == 0 {
                        return false
                    }
                }
            }
            return true
        }.asDriver(onErrorJustReturn: false)
        
        input.btObserver.flatMap(isModify ? doModify : doSignUp).subscribe { event in
            switch event {
            case .next(let user):
                signUpRelay.accept(user)
            case .error(let error):
                errorRelay.accept(error)
            default:
                break
            }
        }.disposed(by: disposeBag)
        
        output.goSignUp = signUpRelay.asSignal()
        output.error = errorRelay.asSignal()
        
    }
    
    func doSignUp() -> Observable<User> {
        return Observable<User>.create { observer in
            
            Auth.auth().createUser(withEmail: self.user.email, password: self.user.pwd) { user, error in
                if let _ = error {
                    let error = KnowingError(code: 101, msg: "일시적인 에러입니다. 잠시후 다시 시도해주세요")
                    observer.onError(error)
                    return
                }
                guard let uid = user?.user.uid else { return }
                let header:HTTPHeaders = ["uid": uid,
                                          "Content-Type":"application/json"]
                
                let url = "https://www.makeus-hyun.shop/app/users/sign-up"
                
                let jsonData = try? JSONEncoder().encode(self.user)
                AF.request(url, method: .post, headers: header)
                    { urlRequest in urlRequest.httpBody = jsonData }
                    .responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            print(json)
                            let result = json["result"].dictionaryObject
                            if let isSuccess = result?["isSuccess"] as? Bool,
                               let code = result?["code"] as? Int {
                                if isSuccess {
                                    observer.onNext(self.user)
                                } else {
                                    let error = KnowingError(code: code, msg: "일시적인 에러입니다. 잠시후 다시 시도해주세요")
                                    observer.onError(error)
                                }
                            }
                        case .failure(_):
                            let knowingError = KnowingError(code: 404, msg: "네트워크 연결상태를 확인해주세요.")
                            observer.onError(knowingError)
                        }
                    }
            }
            
            
            return Disposables.create()
        }
        
    }
    
    func doModify() -> Observable<User> {
        
        return Observable<User>.create { observer in
            
            let uid = "MHQ72TN4d8dFFL2b74Ldy4s3EHa2"//Auth.auth().currentUser!.uid
            let header:HTTPHeaders = ["uid": uid,
                                      "Content-Type":"application/json"]
            let url = "https://www.makeus-hyun.shop/app/users/usermodify/welfare"
            
            let body:[String: [String]] = ["studentCategory": self.user.studentCategory,
                                           "empolyCategory": self.user.empolyCategory,
                                           "foundationCategory": self.user.foundationCategory,
                                           "residentCategory": self.user.residentCategory,
                                           "lifeCategory": self.user.lifeCategory,
                                           "covidCategory": self.user.covidCategory]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            AF.request(url, method: .post, encoding: JSONEncoding.default, headers: header)
                { urlRequest in urlRequest.httpBody = jsonData }
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        print(value)
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
}
