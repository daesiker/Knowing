//
//  AppDelegate.swift
//  Knowing
//
//  Created by Jun on 2021/10/15.
//

import UIKit
import Firebase
import GoogleSignIn
import SnapKit
import NaverThirdPartyLogin
import KakaoSDKCommon
import KakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Firebase
        FirebaseApp.configure()
        
        //Naver
        let naverInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        naverInstance?.isInAppOauthEnable = true
        naverInstance?.serviceUrlScheme = kServiceAppUrlScheme
        naverInstance?.consumerKey = kConsumerKey
        naverInstance?.consumerSecret = kConsumerSecret
        naverInstance?.appName = kServiceAppName
        
        //Kakao
        KakaoSDKCommon.initSDK(appKey: "c705c8d6c41cc65f942de4506e52456c")
        
        //Google
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error == nil, let _ = user {
                
            } else {
                
            }
        }
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.handleOpenUrl(url: url)
        }
        
        let naverSession = NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
        let googleSession = GIDSignIn.sharedInstance.handle(url)
        return googleSession || naverSession
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

