//
//  SignUpViewController.swift
//  77.Ins
//
//  Created by Kiichi Ikeda on 2020/07/31.
//  Copyright © 2020 net.Chee-Saga. All rights reserved.
//

import UIKit
import PKHUD
import NCMB

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var eMailTextField: UITextField!
    @IBOutlet var passwardTextField: UITextField!
    @IBOutlet var confirmTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        eMailTextField.delegate = self
        passwardTextField.delegate = self
        confirmTextField.delegate = self
        
        passwardTextField.textContentType = .oneTimeCode
        confirmTextField.textContentType = .oneTimeCode
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

    @IBAction func signUp(){
        if confirmTextField.text != passwardTextField.text {
            HUD.flash(.error, delay: 1)
            return
        }
        if  userNameTextField.text!.count <= 3 {
            HUD.flash(.labeledError(title: "Error", subtitle: "IDの文字数が\n足りません。"), delay: 1)
            return
        }
        let user = NCMBUser.init()
        
        user.userName = userNameTextField.text
        user.mailAddress = eMailTextField.text
        user.password = passwardTextField.text
        let acl = NCMBACL.init()
        acl.setPublicReadAccess(true)
        acl.setPublicWriteAccess(true)
        user.acl = acl
        HUD.show(.progress, onView: view)
        user.signUpInBackground { (error) in
            if error != nil {
                HUD.hide()
                HUD.flash(.labeledError(title: "Error", subtitle: "登録できませんでした。"), delay: 1){
                    finished in
                    HUD.flash(.label(error?.localizedDescription), delay: 2)
                }
                return
            }
            HUD.flash(.labeledSuccess(
                title: "登録成功",
                subtitle: "登録ありがとう\nございます！"
            ), delay: 1.0) { finished in
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

}
