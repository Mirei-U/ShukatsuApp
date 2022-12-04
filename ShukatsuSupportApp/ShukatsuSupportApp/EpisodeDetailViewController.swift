//
//  EpisodeDetailViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/21.
//

import UIKit
import RealmSwift
import SwiftUI

//試しに作っているやつ
class EpisodeDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet var タイトル : UITextField!
    @IBOutlet var 評価点: UITextField!
    @IBOutlet var 具体的に何をした: UITextView!
    @IBOutlet var 目標と困難: UITextView!
    @IBOutlet var 工夫した点: UITextView!
    @IBOutlet var 取り組んだ結果: UITextView!
    @IBOutlet var 活かせた長所: UITextView!
    @IBOutlet var 改善点: UITextView!
    @IBOutlet var 学んだこと: UITextView!
    
    var 選択肢: [String] = []
    weak var pickerView: UIPickerView?
    
    //Realmを使うときのお決まりのやつ
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        タイトル.placeholder = "タイトルを入力してください"
        //データをコンソールに表示
        let userData = realm.objects(User.self)
        
        選択肢.append("")
        選択肢.append("5: 満足")
        選択肢.append("4: 少し満足")
        選択肢.append("3: 普通")
        選択肢.append("2: 少し不満")
        選択肢.append("1: 不満")
        
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self

        評価点.delegate = self
        評価点.inputAssistantItem.leadingBarButtonGroups = []
        評価点.inputView = pv
        self.pickerView = pv

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        print("🟥全てのデータ\(userData)")
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    //評価点PickerView
    //↓↓↓↓
        @objc func dismissKeyboard() {
            self.view.endEditing(true)
        }
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return 選択肢.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return 選択肢[row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            評価点.text = 選択肢[row]
        }
    //↑↑↑↑
    @IBAction func 保存(_ sender: Any) {
        
        if(タイトル.text! == ""){
            showAlert()
        }else{
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
        
        switch 評価点.text{
        case "5: 満足":
            user.user評価点 = "5"
            print("5点")
            break
        case "4: 少し満足":
            user.user評価点 = "4"
            print("4点")
            break
        case "3: 普通":
            user.user評価点 = "3"
            print("3点")
            break
        case "2: 少し不満":
            user.user評価点 = "2"
            print("2点")
            break
        case "1: 不満":
            user.user評価点 = "1"
            print("1点")
            break
        default:
            user.user評価点 = ""
            print("評価未記入")
        }
        
        try! realm.write {
            realm.add(user)
        }
    }
       
    func showAlert() {
            let alertController = UIAlertController(title: "保存できません", message: "タイトルを入力してください", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
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
