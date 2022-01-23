//
//  SceneDelegate.swift
//  IketenMentorStudy01_NCMB01
//
//  Created by Kiichi Ikeda on 2022/01/23.
//

import UIKit
import NCMB

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        
        // ログイン中か、判定。
        if NCMBUser.current() != nil {
            // ログイン中だったら
            self.window = window
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)//
            self.window?.rootViewController = storyboard.instantiateInitialViewController()
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
        } else {
            // ログインしていなかったら
            self.window = window
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            self.window?.rootViewController = storyboard.instantiateInitialViewController()
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
        }
        // MARK: 課題①
        /*
         ストーリボードを指定する、ここのコード
         みた感じ、なんか同じコード2回書いてたりして、ちょっと、カッコ悪い！
         今、20~35行目で、15行も使っちゃってるね！
         
         これを、スマートに（シンプルに）する方法を考えてね！
         */
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

