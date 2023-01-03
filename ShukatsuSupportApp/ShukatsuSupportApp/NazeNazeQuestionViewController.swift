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
    var text_タイトル:String = ""
    var text_なぜなぜ1:String = ""
    var text_なぜなぜ2:String = ""
    var text_なぜなぜ3:String = ""
    var text_なぜなぜ4:String = ""
    var text_なぜなぜ5:String = ""
    var id:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        テーマ.text = text_タイトル
        なぜなぜ1.text = text_なぜなぜ1
        なぜなぜ2.text = text_なぜなぜ2
        なぜなぜ3.text = text_なぜなぜ3
        なぜなぜ4.text = text_なぜなぜ4
        なぜなぜ5.text = text_なぜなぜ5
        print("text_なぜなぜ1: \(text_なぜなぜ1)")
    }
    override func viewWillAppear(_ animated: Bool) {
//        edit.removeUserDefaults()

//        let userData = edit.realm.objects(User.self)
//        テーマ.text = userData[0].userタイトル
        
    }

    @IBAction func 保存(_ sender: Any) {
        
        //グラフ画面に戻る
        self.navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
        print("⏪戻る")
        let user = User()
        user.userなぜなぜ1 = なぜなぜ1.text!
        user.userなぜなぜ2 = なぜなぜ2.text!
        user.userなぜなぜ3 = なぜなぜ3.text!
        user.userなぜなぜ4 = なぜなぜ4.text!
        user.userなぜなぜ5 = なぜなぜ5.text!
        
        
        do{
            try realm.write {
    //            realm.delete(realm.objects(User.self))
    //            realm.add(realm.objects(User.self))
    //            realm.delete(user)
//                realm.add(user)
                let targetUser = realm.object(ofType: User.self, forPrimaryKey: id)
//                let targetUser = realm.objects(User.self).filter("userタイトル == %@",self.text_タイトル)
                targetUser!.userなぜなぜ1 = なぜなぜ1.text!
                targetUser!.userなぜなぜ2 = なぜなぜ2.text!
                targetUser!.userなぜなぜ3 = なぜなぜ3.text!
                targetUser!.userなぜなぜ4 = なぜなぜ4.text!
                targetUser!.userなぜなぜ5 = なぜなぜ5.text!
                print("更新後: \(targetUser!.userなぜなぜ1)")
//                targetUser.userなぜなぜ2 = なぜなぜ2.text!
//                targetUser.userなぜなぜ3 = なぜなぜ3.text!
//                targetUser.userなぜなぜ4 = なぜなぜ4.text!
//                targetUser.userなぜなぜ5 = なぜなぜ5.text!
            }
        }catch {
          print("Error \(error)")
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
