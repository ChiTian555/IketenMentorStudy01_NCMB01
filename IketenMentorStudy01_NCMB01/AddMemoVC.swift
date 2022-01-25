//
//  AddMemoVC.swift
//  IketenMentorStudy01_NCMB01
//
//  Created by Kiichi Ikeda on 2022/01/23.
//

import UIKit
import NCMB
import PKHUD

class AddMemoVC: UIViewController {

    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func saveMemo(_ sender: UIButton) {
        guard let user = NCMBUser.current() else {
            HUD.flash(.label("ログインされていません。\nサインイン画面に戻ります。"), onView: view, delay: 2) { _ in
                let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                let rootViewController = storyboard.instantiateInitialViewController()
                UIApplication.shared.keyWindow?.rootViewController = rootViewController
            }; return
        }
        let memo = NCMBObject(className: "Memo")
        memo?.setObject(memoTextView.text ?? "", forKey: "text")
        memo?.setObject(user, forKey: "user")
        memo?.saveInBackground {
            if $0 != nil {
                HUD.flash(.label($0?.localizedDescription), onView: self.view, delay: 2)
            }
            self.dismiss(animated: true, completion: nil)
            (self.presentingViewController as! MemoSearchVC).displayAllMemo()
        }
    }
    
    @IBAction func back(_ sender: UIButton) { self.dismiss(animated: true, completion: nil) }
    
    
}
