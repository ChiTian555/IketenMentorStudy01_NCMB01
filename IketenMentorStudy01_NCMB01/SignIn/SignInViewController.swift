//
//  SignInViewController.swift
//  77.Ins
//
//  Created by Kiichi Ikeda on 2020/07/31.
//  Copyright © 2020 net.Chee-Saga. All rights reserved.
//

import UIKit
import NCMB
import PKHUD

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var userIdTextField: UITextField!
    @IBOutlet var passwardTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIdTextField.delegate = self
        passwardTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func signIn() {
        if userIdTextField.text?.count == 0 || passwardTextField.text?.count == 0 {return}
        
        NCMBUser.logInWithUsername(inBackground: userIdTextField.text, password: passwardTextField.text) { (user, error) in
            if error != nil {
                HUD.flash(.labeledError(title: "Error", subtitle: "ログインできませんでした。"), delay: 1){
                    finished in
                    HUD.flash(.label(error?.localizedDescription), delay: 2)
                }
            } else {
                self.succeedLogin()
            }
        }
    }
    
    func succeedLogin() {
        HUD.flash(.labeledSuccess(title: "ログイン完了", subtitle: "おかえりなさいませ♪"), delay: 1) {
            finished in
        
            let ud = UserDefaults.standard
            ud.set(true, forKey: "isLogin")
            ud.synchronize()
            
            let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateInitialViewController()
            keyWindow?.rootViewController = rootViewController
        }
    }
}


