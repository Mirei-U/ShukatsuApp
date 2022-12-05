//
//  NazeNazeQuestionViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/12/05.
//

import UIKit
import RealmSwift

class NazeNazeQuestionViewController: UIViewController {

    @IBOutlet weak var テーマ: UILabel!
    @IBOutlet weak var なぜなぜ1: UITextView!
    @IBOutlet weak var なぜなぜ2: UITextView!
    @IBOutlet weak var なぜなぜ3: UITextView!
    @IBOutlet weak var なぜなぜ4: UITextView!
    @IBOutlet weak var なぜなぜ5: UITextView!
    
    let edit = EpisodeDetailViewController()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userData = edit.realm.objects(User.self)
        テーマ.text = userData[0].userタイトル
    }
    override func viewWillAppear(_ animated: Bool) {
//        edit.removeUserDefaults()

//        let userData = edit.realm.objects(User.self)
//        テーマ.text = userData[0].userタイトル
        
    }

    @IBAction func 保存(_ sender: Any) {
        
        
        //グラフ画面に戻る
        self.navigationController?.popToViewController(navigationController!.viewControllers[1], animated: true)
        print("⏪戻る")
        let user = User()
        user.userなぜなぜ1 = なぜなぜ1.text!
        user.userなぜなぜ2 = なぜなぜ2.text!
        user.userなぜなぜ3 = なぜなぜ3.text!
        user.userなぜなぜ4 = なぜなぜ4.text!
        user.userなぜなぜ5 = なぜなぜ5.text!
        
        try! realm.write {
//            realm.delete(realm.objects(User.self))
//            realm.add(realm.objects(User.self))
            realm.add(user)
        }
    }
       
    func showAlert() {
            let alertController = UIAlertController(title: "保存できません", message: "タイトルを入力してください", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
    }

        //テーブルをリセット
//        tableView.reloadData()
}
