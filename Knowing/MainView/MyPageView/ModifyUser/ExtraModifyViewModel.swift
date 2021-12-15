//
//  ExtraModifyViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/12/14.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON
import Firebase

class ExtraModifyViewModel {
    var user:User
    let disposeBag = DisposeBag()
    
    let input = Input()
    let output = Output()
    
    
    struct Input {
        let cityValue = PublishRelay<String>()
        let guValue = PublishRelay<String>()
        let specialValue = PublishRelay<String>()
        let specialViewDismiss = PublishRelay<Void>()
        let incomeValue = PublishRelay<String>()
        let employValue = PublishRelay<String>()
        let recordsValue = PublishRelay<String>()
        let schoolValue = PublishRelay<String>()
        let mainMajorValue = PublishRelay<String>()
        let subMajorValue = PublishRelay<String>()
        let semesterValue = PublishRelay<String>()
        let scoreValue = PublishRelay<String>()
        let modifyBt = PublishRelay<Void>()
    }
    
    struct Output {
        let cityValue = PublishRelay<String>()
        let guValue = PublishRelay<String>()
        let specialValue = PublishRelay<[String]>()
        let specialBtEnable = PublishRelay<Bool>()
        let specialViewDismiss = PublishRelay<Void>()
        let schoolValue = PublishRelay<String>()
        let successValue = PublishRelay<Void>()
        let errorValue = PublishRelay<Error>()
    }
    
    init(user: User) {
        self.user = user
        
        input.cityValue.subscribe(onNext: { value in
            self.user.address = value
            self.user.addressDetail = ""
            self.output.cityValue.accept(value)
        }).disposed(by: disposeBag)
        
        input.guValue.subscribe(onNext: { value in
            self.user.addressDetail = value
            self.output.guValue.accept(value)
        }).disposed(by: disposeBag)
        
        input.specialValue.subscribe(onNext: { value in
            if value == "none" {
                if self.user.specialStatus.contains("none") {
                    self.user.specialStatus = []
                } else {
                    self.user.specialStatus = ["none"]
                }
            } else {
                if !self.user.specialStatus.contains("none") {
                    if self.user.specialStatus.contains(value) {
                        let index = self.user.specialStatus.firstIndex(of: value) ?? 0
                        self.user.specialStatus.remove(at: index)
                    } else {
                        self.user.specialStatus.append(value)
                    }
                } else {
                    self.user.specialStatus = ["none"]
                }
            }
            
            if self.user.specialStatus.count != 0 {
                self.output.specialBtEnable.accept(true)
            } else {
                self.output.specialBtEnable.accept(false)
            }
            print(self.user.specialStatus)
            self.output.specialValue.accept(self.user.specialStatus)
        }).disposed(by: disposeBag)
        
        input.specialViewDismiss.subscribe(onNext: {
            self.output.specialViewDismiss.accept(())
        }).disposed(by: disposeBag)
        
        
        input.incomeValue.subscribe(onNext: {value in
            let income = Int(value.replacingOccurrences(of: ",", with: "")) ?? 0
            self.incomeQuintile(income)
        }).disposed(by: disposeBag)
        
        input.employValue.subscribe(onNext: {value in
            if value == "전체" {
                if self.user.employmentState.contains(value) {
                    self.user.employmentState = []
                } else {
                    self.user.employmentState = [value]
                }
            } else {
                if self.user.employmentState == ["전체"] {
                    self.user.employmentState = [value]
                } else if self.user.employmentState.contains(value) {
                    let index = self.user.employmentState.firstIndex(of: value) ?? 0
                    self.user.employmentState.remove(at: index)
                } else {
                    self.user.employmentState.append(value)
                }
            }
        }).disposed(by: disposeBag)
        
        input.recordsValue.subscribe(onNext: { value in
            self.user.schoolRecords = value
        }).disposed(by: disposeBag)
        
        input.schoolValue.subscribe(onNext: { value in
            self.user.school = value
            self.output.schoolValue.accept(value)
        }).disposed(by: disposeBag)
        
        input.mainMajorValue.subscribe(onNext: { value in
            self.user.mainMajor = value
        }).disposed(by: disposeBag)
        
        input.subMajorValue.subscribe(onNext: { value in
            self.user.subMajor = value
        }).disposed(by: disposeBag)
        
        input.semesterValue.subscribe(onNext: { value in
            self.user.semester = value
        }).disposed(by: disposeBag)
        
        input.scoreValue.subscribe(onNext: { value in
            self.user.lastSemesterScore = value
        }).disposed(by: disposeBag)
        
        input.modifyBt.flatMap(modifyUser).subscribe({ event in
            
            switch event {
            case .next(_):
                self.output.successValue.accept(())
            case .completed:
                break
            case .error(let error):
                self.output.errorValue.accept(error)
            }
            
        }).disposed(by: disposeBag)
        
    }
    
    func incomeQuintile(_ value: Int) {
        if value <= 1462887 {
            self.user.incomeLevel = "1"
            self.user.incomeAvg = "30"
        } else if value <= 2438145 {
            self.user.incomeLevel = "2"
            self.user.incomeAvg = "50"
        } else if value <= 3413403 {
            self.user.incomeLevel = "3"
            self.user.incomeAvg = "70"
        } else if value <= 4388661 {
            self.user.incomeLevel = "4"
            self.user.incomeAvg = "90"
        } else if value <= 4876290 {
            self.user.incomeLevel = "5"
            self.user.incomeAvg = "100"
        } else if value <= 6339177 {
            self.user.incomeLevel = "6"
            self.user.incomeAvg = "130"
        } else if value <= 7314435 {
            self.user.incomeLevel = "7"
            self.user.incomeAvg = "150"
        } else if value <= 9752580 {
            self.user.incomeLevel = "8"
            self.user.incomeAvg = "200"
        } else if value <= 14628870 {
            self.user.incomeLevel = "9"
            self.user.incomeAvg = "300"
        } else {
            self.user.incomeLevel = "9"
            self.user.incomeAvg = "300"
        }
    }
    
    func modifyUser() -> Observable<Bool> {
        
        return Observable.create { observer in
            
            if self.user.checkAvailable() {
                let uid = Auth.auth().currentUser?.uid ?? MainTabViewModel.instance.user.getUid()
                let url = "https://www.makeus-hyun.shop/app/users/usermodify/plusinfo"
                let header:HTTPHeaders = ["userUid": uid,
                                          "Content-Type":"application/json"]
                let body:[String: Any] = self.user.extraJson()
                let jsonData = try? JSONSerialization.data(withJSONObject: body, options: [])
                AF.request(url, method: .post, headers: header)
                    { urlRequest in urlRequest.httpBody = jsonData }
                    .responseJSON { response in
                        switch response.result {
                        case .success(_):
                            observer.onNext(true)
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
            } else {
                let error = KnowingError(code: 101, msg: "필수데이터를 입력해주세요.")
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    
    
}
