//
//  EpisodeDetailViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/21.
//

import UIKit
import RealmSwift

//試しに作っているやつ
class EpisodeDetailViewController: UIViewController{
    @IBOutlet var タイトル : UITextField!
    @IBOutlet var 具体的に何をした: UITextView!
    @IBOutlet var 目標と困難: UITextView!
    @IBOutlet var 工夫した点: UITextView!
    @IBOutlet var 取り組んだ結果: UITextView!
    @IBOutlet var 活かせた長所: UITextView!
    @IBOutlet var 改善点: UITextView!
    @IBOutlet var 学んだこと: UITextView!
    
    
    //Realmを使うときのお決まりのやつ
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        タイトル.placeholder = "タイトルを入力してください"
        //データをコンソールに表示
        let userData = realm.objects(User.self)
        print("🟥全てのデータ\(userData)")
    }
    
    @IBAction func 保存(_ sender: Any) {
        //グラフ画面に戻る
        self.navigationController?.popToViewController(navigationController!.viewControllers[1], animated: true)
        print("⏪戻る")
        let user = User()
        user.userタイトル = タイトル.text!
        user.user具体的に何をした = 具体的に何をした.text!
        user.user目標と困難 = 目標と困難.text!
        user.user工夫した点 = 工夫した点.text!
        user.user取り組んだ結果 = 取り組んだ結果.text!
        user.user活かせた長所 = 活かせた長所.text!
        user.user改善点 = 改善点.text!
        user.user学んだこと = 学んだこと.text!
        try! realm.write {
            realm.add(user)
        }

        //書いた後リセット
//        タイトル.text = ""
//        具体的に何をした.text = ""
//        目標と困難.text = ""
//        工夫した点.text = ""
//        取り組んだ結果.text = ""
//        活かせた長所.text = ""
//        改善点.text = ""
//        学んだこと.text = ""
        
        //テーブルをリセット
//        tableView.reloadData()
        
    }
    


}
