//
//  SignUpViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/11/02.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class SignUpViewModel {
   
    let disposeBag = DisposeBag()
    let input = Input()
    var output = Output()
    var user = User()
    
    
    
    struct Input {
        let nameObserver = PublishRelay<String>()
        let emailObserver = PublishRelay<String>()
        let pwObserver = PublishRelay<String>()
        let pwConfirmObserver = PublishRelay<String>()
        let phoneObserver = PublishRelay<String>()
        let genderObserver = PublishRelay<Gender>()
        let birthObserver = PublishRelay<String>()
        let signUpObserver = PublishRelay<Bool>()
        
    }
    
    struct Output {
        var emailValid:Driver<EmailValid> = PublishRelay<EmailValid>().asDriver(onErrorJustReturn: .notAvailable)
        var pwValid:Driver<Bool> = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var pwConfirmValid:Driver<Bool> =  PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        var genderValid:Driver<Gender> = PublishRelay<Gender>().asDriver(onErrorJustReturn: .notSelected)
        var buttonValid:Driver<Bool> = PublishRelay<Bool>().asDriver(onErrorJustReturn: false)
        
    }
    
    init() {
        input.nameObserver.subscribe(onNext: {valid in
            self.user.name = valid
        }).disposed(by: disposeBag)
        
        input.emailObserver.subscribe(onNext: {valid in
            self.user.email = valid
        }).disposed(by: disposeBag)
        
        input.pwObserver.subscribe(onNext: {valid in
            self.user.pwd = valid
        }).disposed(by: disposeBag)
        
        input.phoneObserver.subscribe(onNext: {valid in
            self.user.phNum = valid
        }).disposed(by: disposeBag)
        
        input.genderObserver.subscribe(onNext: {valid in
            switch valid {
            case .male:
                self.user.gender = "남성"
            case .female:
                self.user.gender = "여성"
            case .notSelected:
                break
            }
        }).disposed(by: disposeBag)
        
        input.birthObserver.subscribe(onNext: {valid in
            let dateComponent = valid.components(separatedBy: " / ")
            let year = Int(dateComponent[0]) ?? 1995
            let month = Int(dateComponent[1]) ?? 10
            let day = Int(dateComponent[2]) ?? 12
            let date = DateComponents(year: year, month: month, day: day)
            let calendar = Calendar.current
            let now = calendar.dateComponents([.year, .month, .day], from: Date())
            let ageComponents = calendar.dateComponents([.year], from: date, to: now)
            let age = ageComponents.year ?? 20
            
            self.user.birth = age
            
        }).disposed(by: disposeBag)
        
        
        output.emailValid = input.emailObserver
            .flatMap(self.emailCheck)
            .asDriver(onErrorJustReturn: .notAvailable)
        
        output.pwValid = input.pwObserver
            .map { $0.validpassword() }
            .asDriver(onErrorJustReturn: false)
        
        output.pwConfirmValid = Driver.combineLatest(input.pwObserver.asDriver(onErrorJustReturn: ""), input.pwConfirmObserver.asDriver(onErrorJustReturn: ""))
            .map { $0 == $1 }
            .asDriver(onErrorJustReturn: false)
        
        output.genderValid = input.genderObserver.asDriver(onErrorJustReturn: .notSelected)
        
        output.buttonValid = Driver.combineLatest(output.emailValid, output.pwValid, input.nameObserver.asDriver(onErrorJustReturn: ""), input.genderObserver.asDriver(onErrorJustReturn: .notSelected), input.birthObserver.asDriver(onErrorJustReturn: ""), output.pwConfirmValid, input.phoneObserver.asDriver(onErrorJustReturn: "")).map { a, b, c, d, e, f, g in
            
            if a == .correct {
                if b && c != "" {
                    if d != .notSelected && e != "" {
                        if f && g != "" {
                            return true
                        }
                    }
                }
            }
            return false
            
        }
            .asDriver(onErrorJustReturn: false)
        
    }
    
    func emailCheck(_ string: String) -> Observable<EmailValid> {
        
        return Observable.create { valid in
            
            if !(!string.isEmpty && string.contains(".") && string.contains("@")) {
                valid.onNext(.notAvailable)
                valid.onCompleted()
            }
            
            let url = "https://www.makeus-hyun.shop/app/users/checkemail?email=\(string)"
            AF.request(url, method: .get, encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let result = json["result"].dictionaryObject
                        
                        if let result = result?["status"] as? Bool {
                            if result {
                                valid.onNext(.correct)
                            } else {
                                valid.onNext(.alreadyExsist)
                            }
                        }
                    default:
                        valid.onNext(.serverError)
                    }
                    
                    
                }
            
            
            
            return Disposables.create()
        }
        
    }
    
    
}
