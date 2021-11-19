//
//  LoginViewModel.swift
//  Knowing
//
//  Created by Jun on 2021/10/15.
//

//import Foundation
//import RxSwift
//import RxCocoa
//import Firebase
//import GoogleSignIn
//import NaverThirdPartyLogin
//
//class LoginViewModel {
//    
//    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
//    var disposeBag:DisposeBag = DisposeBag()
//    var input:Input = Input()
//    var output:Output
//    
//    struct Input {
//        let googleLoginTap = PublishRelay<UIViewController>()
//        let naverLoginTap = PublishRelay<Void>()
//    }
//    
//    struct Output {
//        let apiSignUpRelay: Signal<Bool>
//    }
//    
//    init() {
//        let apiSingnUpRelay = PublishRelay<Bool>()
//        
//        self.output = Output(apiSignUpRelay: apiSingnUpRelay.asSignal())
//        
//        input.naverLoginTap
//            .map{ self.naverLoginInstance?.requestThirdPartyLogin }
//            .subscribe { event in
//                switch event {
//                case .completed:
//                    print("completed")
//                case .next(_):
//                    print("next")
//                case .error(let error):
//                    print(error)
//                }
//            }
//            .disposed(by: disposeBag)
//        
//        input.googleLoginTap.flatMapLatest(googleLogin)
//            .subscribe { event in
//                switch event {
//                case .completed:
//                    print("completed")
//                case .next(let value):
//                    apiSingnUpRelay.accept(value)
//                case .error(let error):
//                    print(error)
//                }
//            }
//            .disposed(by: disposeBag)
//        
//    }
//    
//    func googleLogin(vc: UIViewController) -> Observable<Bool> {
//        return Observable.create { observer in
//            let clientID = FirebaseApp.app()?.options.clientID ?? ""
//            let signInConfig = GIDConfiguration.init(clientID: clientID)
//            
//            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: vc) { user, error in
//                if let error = error {
//                    observer.onError(error)
//                }
//                
//                guard let authentication = user?.authentication,
//                      let idToken = authentication.idToken
//                else { return }
//                
//                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
//                
//                Auth.auth().signIn(with: credential) { result, error in
//                    if let error = error {
//                        observer.onError(error)
//                    }
//                    
//                    if result != nil {
//                        guard let uid = Auth.auth().currentUser?.uid else { return }
//                        print(uid)
//                        observer.onNext(true)
//                    }
//                }
//            }
//            return Disposables.create()
//        }
//    }
//    
//    
//    
//}


