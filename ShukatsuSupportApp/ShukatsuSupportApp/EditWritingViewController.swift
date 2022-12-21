//
//  EditWritingViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/12/05.
//

import UIKit
import RealmSwift

class EditWritingViewController: UIViewController {

    //Realmを使うときのお決まりのやつ
    let realm = try! Realm()
    
    @IBOutlet weak var 結論: UITextView!
    @IBOutlet weak var 動機: UITextView!
    @IBOutlet weak var 目標と困難: UITextView!
    @IBOutlet weak var 取り組みと結果: UITextView!
    @IBOutlet weak var 人柄: UITextView!
    @IBOutlet weak var 学び: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func 保存(_ sender: Any) {

        //1つ前に戻る
        self.navigationController?.popViewController(animated: true)
        print("⏪戻る")
        let user = User()
        user.user文章作成_結論 = 結論.text!
        user.user文章作成_動機 = 動機.text!
        user.user文章作成_目標と困難 = 目標と困難.text!
        user.user文章作成_取り組みと結果 = 取り組みと結果.text!
        user.user文章作成_人柄 = 人柄.text!
        user.user文章作成_学び = 学び.text!
        
        try! realm.write {
//            realm.delete(realm.objects(User.self))
            realm.add(user)
        }
    }
}
