//
//  AppDelegate.swift
//  IketenMentorStudy01_NCMB01
//
//  Created by Kiichi Ikeda on 2022/01/23.
//

import UIKit
import NCMB

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let aKey = "186ff65927ee3619943bb8c501a0cc4aa7d61b441fa39c0c71f2d3ce9254aa52"
        let cKey = "e2839459b69bb7f72c6a3803ebf502b39fef4107c6881e22f77c7a49a769d809"
        NCMB.setApplicationKey(aKey, clientKey: cKey)
        
        return true
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

