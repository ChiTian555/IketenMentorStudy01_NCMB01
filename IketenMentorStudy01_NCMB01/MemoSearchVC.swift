//
//  ViewController.swift
//  IketenMentorStudy01_NCMB01
//
//  Created by Kiichi Ikeda on 2022/01/23.
//

import UIKit
import NCMB
import PKHUD

class MemoSearchVC: UIViewController, UITableViewDataSource {

    @IBOutlet weak var searchWordTF: UITextField!
    @IBOutlet weak var myIDLabel: UILabel!
    @IBOutlet weak var displayTableView: UITableView!
    
    /*
     今のクラスの説明
     User
     |- objrctId: String
     |- userName: String
     
     Memo
     |- text: String
     |- user: NCMBUser
     */
    
    /// NCMBから取ってきた情報を、String型で保持したい！（お好みで、カスタマイズ可）
    var displayWords: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayTableView.dataSource = self
        displayTableView.allowsSelection = false
        
        // MARK: 課題③
        /*
         NCMBがログインしてるかしてないかを判断して、ログアウトされてたら、SignIn画面に戻るためのコードです。
         しかし、以下のように書いたら、ちょっと、viewDidLoadが、煩雑になりますね。
         皆さんで、44~51を、なるべんくシンプルに書き換えてください！
         ここで、他のviewControllerでも使うことを考慮してくれたら尚よし！
         */
        let current = NCMBUser.current()
        if current == nil {
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateInitialViewController()
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
            return
        }
        myIDLabel.text = "MyID:\(current!.objectId!)"
        
        //最初は、全てのメモを表示させる。
        displayAllMemo()
    }
    
    // MARK: 課題②
    /*
     それぞれ、いろんな検索の仕方を、皆さんに考えてもらいます！
     •採点要素としては、何個実装できたか
     •どれだけシンプルに描けたか
     です！
     */
    
    /// UserNameから、Userを検索し、TableViewに表示！
    @IBAction func displayAllUserName(_ sender: UIButton) {
    }
    /// UserNameもしくは、objectIdに一致するUserを、TableViewに表示！
    @IBAction func searchUserByUserNameOrId(_ sender: UIButton) {
    }
    /// Memoから、textの部分一致で、取得してね！できなかったら、完全一致でも可
    @IBAction func seachMemoByText(_ sender: UIButton) {
        // サイトに、部分一致の記事が少ないんだけど、見つけられるかな？？
    }
    /// 投稿者を指定して、Memoを検索し表示！
    @IBAction func searchMemoByUsersName(_ sender: UIButton) {
    }
    
    /// 全体表示のコードです！
    /// 書き方は、みんなにお任せします！
    func displayAllMemo() {
        let query = NCMBQuery(className: "Memo")
        query?.findObjectsInBackground { [self] (res, err) in
            // エラー処理
            if let err = err { HUD.flash(.labeledError(
                title: "Errro",
                subtitle: err.localizedDescription )); return
            }
            displayWords = (res as! [NCMBObject]).map{$0.object(forKey: "text") as! String }
            displayTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = displayWords[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    /// 下のIDラベルのタップでメニューを表示！
    @IBAction func idTapped(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "メニュー", message: nil, preferredStyle: .actionSheet)
        let logout = UIAlertAction(title: "ログアウト", style: .default) { _ in
            let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateInitialViewController()
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
        }
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel)
        alert.addAction(logout)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

