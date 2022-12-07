//
//  EpisodeDetailViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/21.
//

import UIKit
import RealmSwift
import SwiftUI


let YEAR_TO_DATE = Date()
let DATE_FORMATTER = DateFormatter()
var DATE = ""

class EpisodeDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{

    @IBOutlet var タイトル : UITextField!
    @IBOutlet var 日付: UITextField!
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
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    //Realmを使うときのお決まりのやつ
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //データをコンソールに表示
        let userData = realm.objects(User.self)
        
        //日付
        // DateFormatter を使用して書式とロケールを指定する
        DATE_FORMATTER.locale = Locale(identifier: "ja_JP")//日本語にするため
        DATE_FORMATTER.dateFormat = "y年MM月dd日"//これは表示する形を設定
        DATE = DATE_FORMATTER.string(from: YEAR_TO_DATE)//最初に今日の日付を入れておく。
        日付.text = DATE//曜日も表示
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale(identifier: "ja_JP")//日本語にするため
        datePicker.preferredDatePickerStyle = .wheels//ドラムロール
        日付.inputView = datePicker
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        // インプットビュー設定(紐づいているUITextfieldへ代入)
        日付.inputView = datePicker
        日付.inputAccessoryView = toolbar
        //
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
    
    // UIDatePickerのDoneを押したらTextFieldもそれに変わる。
    @objc func done() {
        日付.endEditing(true)
        //(from: datePicker.date))を指定してあげることで
        //datePickerで指定した日付が表示される
        DATE = DATE_FORMATTER.string(from: datePicker.date)
        日付.text = DATE
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func 保存(_ sender: Any) {
        
        if(タイトル.text! == ""){
            showAlert()
        }else{
        //グラフ画面に戻る
        self.navigationController?.popToViewController(navigationController!.viewControllers[1], animated: true)
        print("⏪戻る")
        let user = User()
        user.userタイトル = タイトル.text!
        user.user日付 = 日付.text!
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
//            realm.delete(realm.objects(User.self))
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
    


}
