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
        let medicalObserver = PublishRelay<String>()
        let btObserver = PublishRelay<Void>()
    }
    
    struct Output {
        var buttonValid = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var goSignUp = PublishRelay<User>()
        var goModify = PublishRelay<User>()
        var goError = PublishRelay<Error>()
    }
    
    init(isModify: Bool = false) {
        self.isModify = isModify
        
        input.studentObserver.subscribe(onNext: { value in
            if value == "전체" {
                if self.user.studentCategory.count == 2 {
                    self.user.studentCategory = []
                } else {
                    self.user.studentCategory = ["교내장학금", "교외장학금"]
                }
            } else {
                if self.user.studentCategory.count == 2 {
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
                if self.user.empolyCategory.count == 4 {
                    self.user.empolyCategory = []
                } else {
                    self.user.empolyCategory = ["구직활동지원인턴", "중소중견기업취업지원", "특수분야취업지원", "해외취업및진출지원"]
                }
            } else {
                if self.user.empolyCategory.count == 4 {
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
                if self.user.foundationCategory.count == 3 {
                    self.user.foundationCategory = []
                } else {
                    self.user.foundationCategory = ["창업운영지원", "경영지원", "자본금지원"]
                }
            } else {
                if self.user.foundationCategory.count == 3 {
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
                if self.user.residentCategory.count == 3 {
                    self.user.residentCategory = []
                } else {
                    self.user.residentCategory = ["생활비지원금융혜택", "주거지원", "학자금지원"]
                }
            } else {
                if self.user.residentCategory.count == 3 {
                    self.user.residentCategory = [value]
                }else if self.user.residentCategory.contains(value) {
                    let index = self.user.residentCategory.firstIndex(of: value) ?? 0
                    self.user.residentCategory.remove(at: index)
                } else {
                    self.user.residentCategory.append(value)
                }
            }
        }).disposed(by: disposeBag)
        
        
        
        input.lifeObserver.subscribe(onNext: { value in
            if value == "전체" {
                if self.user.lifeCategory.count == 2 {
                    self.user.lifeCategory = []
                } else {
                    self.user.lifeCategory = ["건강", "문화"]
                }
            } else {
                if self.user.lifeCategory.count == 2 {
                    self.user.lifeCategory = [value]
                }else if self.user.lifeCategory.contains(value) {
                    let index = self.user.lifeCategory.firstIndex(of: value) ?? 0
                    self.user.lifeCategory.remove(at: index)
                } else {
                    self.user.lifeCategory.append(value)
                }
            }
        }).disposed(by: disposeBag)
        
        input.medicalObserver.subscribe(onNext: { value in
            if value == "전체" {
                if self.user.medicalCategory.count == 6 {
                    self.user.medicalCategory = []
                } else {
                    self.user.medicalCategory = ["기본소득지원", "저소득층지원", "재난피해지원", "소득일자리 보전", "기타인센티브", "심리지원"]
                }
            } else {
                if self.user.medicalCategory.count == 6 {
                    self.user.medicalCategory = [value]
                }else if self.user.medicalCategory.contains(value) {
                    let index = self.user.medicalCategory.firstIndex(of: value) ?? 0
                    self.user.medicalCategory.remove(at: index)
                } else {
                    self.user.medicalCategory.append(value)
                }
            }
        }).disposed(by: disposeBag)
        
        output.buttonValid = Observable.of(input.medicalObserver, input.empolyObserver, input.foundationObserver, input.lifeObserver, input.residentObserver, input.studentObserver).merge().map { _ in
            if self.user.medicalCategory.count == 0 && self.user.empolyCategory.count == 0 {
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
                if self.isModify {
                    self.output.goModify.accept(user)
                } else {
                    self.output.goSignUp.accept(user)
                }
            case .error(let error):
                self.output.goError.accept(error)
            default:
                break
            }
        }.disposed(by: disposeBag)
        
        
    }
    
    func doSignUp() -> Observable<User> {
        return Observable<User>.create { observer in
            if self.user.provider == "default" {
                Auth.auth().createUser(withEmail: self.user.email, password: self.user.pwd) { user, error in
                    if let _ = error {
                        let error = KnowingError(code: 101, msg: "일시적인 에러입니다. 잠시후 다시 시도해주세요")
                        observer.onError(error)
                        return
                    }
                    guard let uid = user?.user.uid else { return }
                    let header:HTTPHeaders = ["uid": uid,
                                              "Content-Type":"application/json"]
                    
                    let url = "https://www.makeus-hyun.shop/app/tmp/sign-up"
                    
                    let jsonData = try? JSONEncoder().encode(self.user)
                    AF.request(url, method: .post, headers: header)
                        { urlRequest in urlRequest.httpBody = jsonData }
                        .responseJSON { response in
                            switch response.result {
                            case .success(let value):
                                let json = JSON(value)
                                let result = json["isSuccess"].boolValue
                                if result {
                                    observer.onNext(self.user)
                                } else {
                                    let error = KnowingError(code: 102, msg: "일시적인 에러입니다. 잠시후 다시 시도해주세요")
                                    observer.onError(error)
                                }
                            case .failure(_):
                                let knowingError = KnowingError(code: 404, msg: "네트워크 연결상태를 확인해주세요.")
                                observer.onError(knowingError)
                            }
                        }
                }
            } else {
                let uid = Auth.auth().currentUser!.uid
                let header:HTTPHeaders = ["uid": uid,
                                          "Content-Type":"application/json"]
                
                let url = "https://www.makeus-hyun.shop/app/tmp/sign-up"
                
                let jsonData = try? JSONEncoder().encode(self.user)
                AF.request(url, method: .post, headers: header)
                    { urlRequest in urlRequest.httpBody = jsonData }
                    .responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            let result = json["isSuccess"].boolValue
                            if result {
                                observer.onNext(self.user)
                            } else {
                                let error = KnowingError(code: 102, msg: "일시적인 에러입니다. 잠시후 다시 시도해주세요")
                                observer.onError(error)
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
            
            let uid = Auth.auth().currentUser!.uid
            let header:HTTPHeaders = ["uid": uid,
                                      "Content-Type":"application/json"]
            let url = "https://www.makeus-hyun.shop/app/tmp/usermodify/welfare"
            
            let body:[String: [String]] = ["studentCategory": self.user.studentCategory,
                                           "empolyCategory": self.user.empolyCategory,
                                           "foundationCategory": self.user.foundationCategory,
                                           "residentCategory": self.user.residentCategory,
                                           "lifeCategory": self.user.lifeCategory,
                                           "medicalCategory": self.user.medicalCategory]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [])
            
            AF.request(url, method: .post, encoding: JSONEncoding.default, headers: header)
                { urlRequest in urlRequest.httpBody = jsonData }
                .responseJSON { response in
                    switch response.result {
                    case .success(_):
                        MainTabViewModel.instance.clear()
                        observer.onNext(self.user)
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
}
