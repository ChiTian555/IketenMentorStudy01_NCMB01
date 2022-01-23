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
        let memo = NCMBObject(className: "Memo")
        memo?.setObject(memoTextView.text ?? "", forKey: "text")
        memo?.saveInBackground {
            if $0 != nil { HUD.flash(.label($0?.localizedDescription), onView: self.view) }
            self.dismiss(animated: true, completion: nil)
            (self.presentingViewController as! MemoSearchVC).displayAllMemo()
        }
    }
    
    @IBAction func back(_ sender: UIButton) { self.dismiss(animated: true, completion: nil) }
    
    
}
