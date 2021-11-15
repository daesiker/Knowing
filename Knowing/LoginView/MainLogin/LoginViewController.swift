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

class LoginViewController: UIViewController {
    
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    let loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    fileprivate var currentNonce: String?
    
    let howToUseLayoutView = UIImageView(image: UIImage(named: "LoginBg"))
    let loginLayoutView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let loginTitle = UILabel().then {
        $0.text = "노잉 시작하기"
        $0.font = UIFont.init(name: "GodoM", size: 17)
    }
    
    let kakaoLoginBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "kakaoLogo"), for: .normal)
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
    
    let naverLoginBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "naverLogo"), for: .normal)
    }
    
    @objc private func naverLogin(_ sender: UIButton) {
        naverLoginInstance?.delegate = self
        naverLoginInstance?.requestThirdPartyLogin()
    }
    
    let googleLoginBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "googleLogo"), for: .normal)
    }
    
    let appleLoginBt = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "appleLogo"), for: .normal)
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
    
    let defaultLoginBt = UIButton(type: .custom).then {
        $0.setTitle("이메일로 로그인", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.setTitleColor(UIColor.rgb(red: 147, green: 147, blue: 147), for: .normal)
        $0.titleEdgeInsets.top = 9
        $0.titleEdgeInsets.bottom = 10
        $0.titleEdgeInsets.left = 16
        $0.titleEdgeInsets.right = 20
    }
    
    let signUpBt = UIButton(type: .custom).then {
        $0.setTitle("이메일로 회원가입", for: .normal)
        $0.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 14)
        $0.setTitleColor(UIColor.rgb(red: 147, green: 147, blue: 147), for: .normal)
        $0.titleEdgeInsets.top = 9
        $0.titleEdgeInsets.bottom = 8
        $0.titleEdgeInsets.left = 20
        $0.titleEdgeInsets.right = 5
    }
    
    let separator = UIView().then {
        $0.backgroundColor = UIColor.rgb(red: 224, green: 224, blue: 224)
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
        safeArea.addSubview(howToUseLayoutView)
        howToUseLayoutView.snp.makeConstraints {
            $0.edges.equalTo(self.view.snp.edges)
        }
        
        view.addSubview(loginLayoutView)
        loginLayoutView.snp.makeConstraints {
            $0.height.equalTo(howToUseLayoutView.snp.height).multipliedBy(0.264)
            $0.bottom.left.right.equalToSuperview()
        }
        
        loginLayoutView.addSubview(loginTitle)
        loginTitle.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(137)
            $0.trailing.equalToSuperview().offset(-137)
        }
        
        let apiFieldStack = UIStackView(arrangedSubviews: [kakaoLoginBt, naverLoginBt, googleLoginBt, appleLoginBt]).then {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.distribution = .fillEqually
        }

        loginLayoutView.addSubview(apiFieldStack)
        apiFieldStack.snp.makeConstraints {
            $0.top.equalTo(loginTitle.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(57.7)
            $0.trailing.equalToSuperview().offset(-56.7)
        }
        
        let loginStack = UIStackView(arrangedSubviews: [defaultLoginBt, signUpBt]).then {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 0
        }
        
        loginLayoutView.addSubview(loginStack)
        loginStack.snp.makeConstraints {
            $0.top.equalTo(apiFieldStack.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(58)
            $0.trailing.equalToSuperview().offset(-56.7)
        }
        
        loginLayoutView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.equalTo(apiFieldStack.snp.bottom).offset(20)
            $0.height.equalTo(loginStack.snp.height).multipliedBy(0.6)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(2)
        }
        
        
    }
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        defaultLoginBt.rx.tap.subscribe(onNext: {
            let viewController = DefaultLoginViewController()
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }).disposed(by: disposeBag)
        
        signUpBt.rx.tap.subscribe(onNext: {
            let viewController = AgreeTermsViewController()
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .fullScreen
            
            self.present(viewController, animated: true)
        }).disposed(by: disposeBag)
        
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

