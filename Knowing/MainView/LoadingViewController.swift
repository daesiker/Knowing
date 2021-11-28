//
//  LoadingViewController.swift
//  Knowing
//
//  Created by Jun on 2021/10/22.
//

import UIKit
import Lottie
import Then
import Alamofire
import SwiftyJSON

class LoadingViewController: UIViewController {
    var user = User()
    var postDic:[String:[Post]] = [:]
    
    
    let animationView = AnimationView(name: "lf20_ng9j9lpx_1").then {
        $0.contentMode = .scaleAspectFill
    }
    
    let largeTitleLabel = UILabel().then {
        $0.attributedText = NSAttributedString(string: "00님의 복지 수혜 예상\n금액을 계산중이에요!").withLineSpacing(6)
        $0.font = UIFont(name: "GodoM", size: 22)
        $0.textColor = UIColor.rgb(red: 185, green: 113, blue: 66)
        $0.numberOfLines = 2
    }
    
    let smallTitleLabel = UILabel().then {
        $0.text = "잠시만 기다려 주세요."
        $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
        $0.textColor = UIColor.rgb(red: 210, green: 132, blue: 81)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.play()
        animationView.loopMode = .loop
        setUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let uid = "MHQ72TN4d8dFFL2b74Ldy4s3EHa2"
        let header:HTTPHeaders = [ "uid": uid,
                                   "Content-Type":"application/json"]
        let url = "https://www.makeus-hyun.shop/app/users/userInfo"
        
        AF.request(url, method: .get, headers: header)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let result = json["result"].dictionaryValue
                    let user = User(json: result)
                    self.user = user
                    self.getPostData()
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
    func setUI() {
        view.backgroundColor = UIColor.rgb(red: 255, green: 225, blue: 182)
        safeArea.addSubview(animationView)
        animationView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(205)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(211)
            $0.height.equalTo(221)
        }
        
        safeArea.addSubview(largeTitleLabel)
        largeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(animationView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(73)
            $0.trailing.equalToSuperview().offset(73)
        }
        
        safeArea.addSubview(smallTitleLabel)
        smallTitleLabel.snp.makeConstraints {
            $0.top.equalTo(largeTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(116)
            $0.trailing.equalToSuperview().offset(-115)
        }
        
    }
    
    func getPostData() {
        let uid = "MHQ72TN4d8dFFL2b74Ldy4s3EHa2"
        let url = "https://www.makeus-hyun.shop/app/mains/mainpage"
        let header:HTTPHeaders = [ "uid": uid,
                                   "Content-Type":"application/json"]
        AF.request(url, method: .get, headers: header)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let result = json["result"].dictionaryValue
                    var myPost:[Post] = []
                    for (key, value) in result {
                        if key != "totalCategory" {
                            let postValue = value.arrayValue
                            var postModels:[Post] = []
                            for post in postValue {
                                let postModel = Post(json: post)
                                myPost.append(postModel)
                                postModels.append(postModel)
                            }
                            self.postDic.updateValue(postModels, forKey: key)
                        } else {
                            let allValue = value.dictionaryValue
                            for (k, v) in allValue {
                                let postValue = v.arrayValue
                                var postModels:[Post] = []
                                for post in postValue {
                                    let postModel = Post(json: post)
                                    postModels.append(postModel)
                                }
                                self.postDic.updateValue(postModels, forKey: "all"+k)
                            }
                        }
                    }
                    myPost.sort { $0.maxMoney > $1.maxMoney }
                    print(myPost)
                    self.postDic.updateValue(myPost, forKey: "myPost")
                    DispatchQueue.main.async {
                        let vc = MainTabViewController()
                        vc.posts = self.postDic
                        vc.user = self.user
                        let nav = UINavigationController(rootViewController: vc)
                        nav.navigationController?.isNavigationBarHidden = true
                        nav.modalTransitionStyle = .crossDissolve
                        nav.modalPresentationStyle = .fullScreen
                        self.present(nav, animated: true)
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
            }
    }
    
    
    
}
