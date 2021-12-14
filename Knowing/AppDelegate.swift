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
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Firebase
        FirebaseApp.configure()
        
        //Push Notifications
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        let authOptions:UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        
        
        //Naver
        let naverInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        naverInstance?.isInAppOauthEnable = true
        naverInstance?.serviceUrlScheme = kServiceAppUrlScheme
        naverInstance?.consumerKey = kConsumerKey
        naverInstance?.consumerSecret = kConsumerSecret
        naverInstance?.appName = kServiceAppName
        
        //Kakao
        KakaoSDK.initSDK(appKey: "d8e0e3e9398b5db90db367e587268a49")
        
        //Google
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error == nil, let _ = user {
                
            } else {
                
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })
        print("[Log] deviceToken :", deviceTokenString)
        Messaging.messaging().apnsToken = deviceToken
        
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.handleOpenUrl(url: url)
        }
        let naverSession = NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
        let googleSession = GIDSignIn.sharedInstance.handle(url)
        return naverSession || googleSession
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



extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcmToken = fcmToken {
            let dataDict:[String:String] = ["token" : fcmToken]
            
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        }
        
    }
    
}
