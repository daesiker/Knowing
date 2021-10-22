//
//  LoginViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/15.
//

import UIKit
import Then
import RxSwift
import NaverThirdPartyLogin
import Alamofire
import AuthenticationServices
import CommonCrypto
import FirebaseAuth
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import FSPagerView

class LoginViewController: UIViewController {
    
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    let loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    fileprivate var currentNonce: String?
    
    let howToUseLayoutView = UIView()
    let loginLayoutView = UIView()
    
    let defaultLoginBt = UIButton(type: .system).then {
        $0.setTitle("노잉 시작하기", for: .normal)
        $0.setTitleColor(UIColor.orange, for: .normal)
        $0.titleLabel?.font = UIFont(name: "", size: 20)
        $0.addTarget(self, action: #selector(defaultLogin), for: .touchUpInside)
    }
    
    @objc private func defaultLogin(_ sender: UIButton) {
//        let viewController = MainTabViewController()
//        let navController = UINavigationController(rootViewController: viewController)
//        navController.isNavigationBarHidden = true
//        navController.modalTransitionStyle = .crossDissolve
//        navController.modalPresentationStyle = .fullScreen
//        self.present(navController, animated: true)
        
        let viewController = LoadingViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
    let kakaoLoginBt = UIButton(type: .system).then {
        $0.setTitle("카카오", for: .normal)
        $0.addTarget(self, action:#selector(kakaoLogin) , for: .touchUpInside)
    }
    
    @objc private func kakaoLogin(_ sender: UIButton) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                    return
                }
                print(oauthToken)
            }
        }
    }
    
    let naverLoginBt = UIButton(type: .system).then {
        $0.setTitle("네이버", for: .normal)
        $0.addTarget(self, action: #selector(naverLogin), for: .touchUpInside)
    }
    
    @objc private func naverLogin(_ sender: UIButton) {
        naverLoginInstance?.delegate = self
        naverLoginInstance?.requestThirdPartyLogin()
    }
    
    let googleLoginBt = UIButton(type: .system).then {
        $0.setTitle("구글", for: .normal)
    }
    
    let appleLoginBt = UIButton(type: .system).then {
        $0.setTitle("애플", for: .normal)
        $0.addTarget(self, action: #selector(appleLogin), for: .touchUpInside)
    }
    
    @objc private func appleLogin(_ sender: UIButton) {
        let nonce = randomNonceString()
        currentNonce = nonce
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
    
    let signUpBt = UIButton(type: .system).then {
        
        let attributedString = NSAttributedString(string: NSLocalizedString("이메일로 회원가입", comment: ""), attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0),
            NSAttributedString.Key.foregroundColor: UIColor.gray,
            NSAttributedString.Key.underlineStyle: 1.0
        ])
        $0.setAttributedTitle(attributedString, for: .normal)
        $0.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
    }
    
    @objc private func goToSignUp(_ sender: UIButton) {
        let viewController = SignUpViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
}

extension LoginViewController {
    
    func setUI() {
        view.backgroundColor = UIColor.mainColor
        safeArea.addSubview(howToUseLayoutView)
        howToUseLayoutView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.8)
        }
        
        safeArea.addSubview(loginLayoutView)
        loginLayoutView.snp.makeConstraints {
            $0.top.equalTo(howToUseLayoutView.snp.bottom)
            $0.bottom.left.right.equalToSuperview()
        }
        
        let apiFieldStack = UIStackView(arrangedSubviews: [kakaoLoginBt, naverLoginBt, googleLoginBt, appleLoginBt]).then {
            $0.axis = .horizontal
            $0.spacing = 20
            $0.distribution = .fillEqually
        }
        
        loginLayoutView.addSubview(defaultLoginBt)
        defaultLoginBt.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
        }
        
        loginLayoutView.addSubview(apiFieldStack)
        apiFieldStack.snp.makeConstraints {
            $0.top.equalTo(defaultLoginBt.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        loginLayoutView.addSubview(signUpBt)
        signUpBt.snp.makeConstraints {
            $0.top.equalTo(apiFieldStack.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        googleLoginBt.rx.tap
            .map { self }
            .bind(to: loginViewModel.input.googleLoginTap)
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        loginViewModel.output.apiSignUpRelay
            .emit { value in
                print(value)
            }
            .disposed(by: disposeBag)
    }
    
}


extension LoginViewController: NaverThirdPartyLoginConnectionDelegate {
    
    private func getNaverInfo() {
        guard let isValidAccessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken { return }
        
        guard let tokenType = naverLoginInstance?.tokenType else { return }
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        guard let url = URL(string: urlStr) else { return }
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        req.responseJSON { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            
            guard let email = object["email"] as? String else { return }
            DispatchQueue.main.async {
                let vc = SignUpViewController()
                self.present(vc, animated: true, completion: nil)
            }
        }
        
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("[Success] : Success Naver Login")
        getNaverInfo()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        naverLoginInstance?.requestDeleteToken()
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("[Error] : ", error.localizedDescription)
    }
    
}



extension LoginViewController: ASAuthorizationControllerDelegate {
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print(error)
                    return
                }
                
                print("success")
            }
            
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error: \(error)")
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms:[UInt8] = (0..<16).map { _ in
                var random:UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if length == 0 { return }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = hashSHA256(data: inputData)
        let hashString = hashedData!.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func hashSHA256(data: Data) -> Data? {
        var hashData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        
        _ = hashData.withUnsafeMutableBytes{ digestBytes in
            data.withUnsafeBytes { messageBytes in
                CC_SHA256(messageBytes, CC_LONG(data.count), digestBytes)
            }
        }
        
        return hashData
    }
    
}

