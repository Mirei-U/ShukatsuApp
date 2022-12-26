////
//  EpisodeDetailViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/21.
//

import UIKit
import RealmSwift
import SwiftUI


let Update_YEAR_TO_DATE = Date()
let Update_DATE_FORMATTER = DateFormatter()
var Update_DATE = ""

protocol UpdateViewControllerDelegate{
    func editDidFinished(modalText: String?)
}

class UpdateEpisodeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet var 更新_タイトル: UITextField!
    @IBOutlet var 更新_日付: UITextField!
    @IBOutlet var 更新_評価: UITextField!
    @IBOutlet var 更新_具体的に何をした: UITextView!
//    @IBOutlet var 更新_日付: UITextField!
//    @IBOutlet var 更新_評価: UITextField!
//    @IBOutlet var 更新_具体的に何をした: UITextView!
//    @IBOutlet var 更新_目標と困難: UITextView!
//    @IBOutlet var 更新_工夫した点: UITextView!
//    @IBOutlet var 更新_取り組んだ結果: UITextView!
//    @IBOutlet var 更新_活かせた長所: UITextView!
//    @IBOutlet var 更新_改善点: UITextView!
//    @IBOutlet var 更新_学んだこと: UITextView!
    
    
    
//    遷移元から受け取る値を設置
    var text_タイトル:String = ""
    var text_具体的に何をした: String = ""
    var text_目標と困難: String = ""
    var text_工夫した点: String = ""
    var text_取り組んだ結果: String = ""
    var text_活かせた長所: String = ""
    var text_改善点: String = ""
    var text_学んだこと: String = ""
    var text_評価: String = ""
    var text_日付: String = ""

    
    var 選択肢: [String] = []
    weak var pickerView: UIPickerView?
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    //Realmを使うときのお決まりのやつ
    let realm = try! Realm()
    //日付でソート
    let results = try! Realm().objects(User.self).sorted(byKeyPath: "user日付")
    
    //編集可能にするための
//    var delegate: UpdateEpisodeViewController! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        初期値入力()
        //日付
        // DateFormatter を使用して書式とロケールを指定する
        DATE_FORMATTER.locale = Locale(identifier: "ja_JP")//日本語にするため
        DATE_FORMATTER.dateFormat = "y年MM月dd日"//これは表示する形を設定
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale(identifier: "ja_JP")//日本語にするため
        datePicker.preferredDatePickerStyle = .wheels//ドラムロール
        更新_日付.inputView = datePicker
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        // インプットビュー設定(紐づいているUITextfieldへ代入)
        更新_日付.inputView = datePicker
        更新_日付.inputAccessoryView = toolbar
        //
        選択肢.append("5: 満足")
        選択肢.append("4: 少し満足")
        選択肢.append("3: 普通")
        選択肢.append("2: 少し不満")
        選択肢.append("1: 不満")
        
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self

        更新_評価.delegate = self
        更新_評価.inputAssistantItem.leadingBarButtonGroups = []
        更新_評価.inputView = pv
        self.pickerView = pv

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        
        //データをコンソールに表示
        let userData = realm.objects(User.self)
        print("🟥全てのデータ\(userData)")
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //更新画面
        更新_タイトル.text! = text_タイトル
        更新_タイトル.delegate = self
        self.view.addSubview(更新_タイトル)
        
        print("🟥UpdateEpisodeViewController_更新_タイトル: \(更新_タイトル.text)")
    }
    func 初期値入力(){
        //=================
        //        更新画面
                更新_タイトル.text! = text_タイトル
                更新_タイトル.delegate = self
                self.view.addSubview(更新_タイトル)
                
                更新_日付.text! = text_日付
        //        更新_日付.delegate = self
        //        self.view.addSubview(更新_日付)
                
                更新_評価.text! = text_評価
        //        更新_評価.delegate = self
        //        self.view.addSubview(更新_評価)
                
                更新_具体的に何をした.text! = text_具体的に何をした
        //        更新_具体的に何をした.delegate = self
        //        self.view.addSubview(更新_具体的に何をした)
                
        //        更新_目標と困難.text! = text_目標と困難
        ////        更新_目標と困難.delegate = self
        ////        self.view.addSubview(更新_目標と困難)
        //
        //        更新_工夫した点.text! = text_工夫した点
        ////        更新_工夫した点.delegate = self
        ////        self.view.addSubview(更新_工夫した点)
        //
        //        更新_取り組んだ結果.text! = text_取り組んだ結果
        ////        更新_取り組んだ結果.delegate = self
        ////        self.view.addSubview(更新_取り組んだ結果)
        //
        //        更新_活かせた長所.text! = text_活かせた長所
        ////        更新_活かせた長所.delegate = self
        ////        self.view.addSubview(更新_活かせた長所)
        //
        //        更新_改善点.text! = text_改善点
        ////        更新_改善点.delegate = self
        ////        self.view.addSubview(更新_改善点)
        //
        //        更新_学んだこと.text! = text_学んだこと
        //        更新_学んだこと.delegate = self
        //        self.view.addSubview(更新_学んだこと)
        //=================
    }
    /*
      UITextFieldが編集された直前に呼ばれる
      */
     func textFieldDidBeginEditing(_ textField: UITextField) {
         print("textFieldDidBeginEditing: \(textField.text!)")
     }

     /*
      UITextFieldが編集された直後に呼ばれる
      */
     func textFieldDidEndEditing(_ textField: UITextField) {
         print("textFieldDidEndEditing: \(textField.text!)")
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
            更新_評価.text = 選択肢[row]
        }
    //↑↑↑↑
    
    // UIDatePickerのDoneを押したらTextFieldもそれに変わる。
    @objc func done() {
        更新_日付.endEditing(true)
        //(from: datePicker.date))を指定してあげることで
        //datePickerで指定した日付が表示される
        DATE = DATE_FORMATTER.string(from: datePicker.date)
        更新_日付.text = DATE
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func 更新を保存(_ sender: Any) {
        
    }
    @IBAction func 保存(_ sender: Any) {
        
        if(更新_タイトル.text! == ""){
            showAlert()
        }else{
        //グラフ画面に戻る
        self.navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
//        self.navigationController?.popToViewController(navigationController!.viewControllers[1], animated: true)
        print("⏪戻る")
        let user = User()
        user.userタイトル = 更新_タイトル.text!
        user.user日付 = 更新_日付.text!
        user.user具体的に何をした = 更新_具体的に何をした.text!
//        user.user目標と困難 = 目標と困難.text!
//        user.user工夫した点 = 工夫した点.text!
//        user.user取り組んだ結果 = 取り組んだ結果.text!
//        user.user活かせた長所 = 活かせた長所.text!
//        user.user改善点 = 改善点.text!
//        user.user学んだこと = 学んだこと.text!
        
        switch 更新_評価.text{
        case "5: 満足":
            user.user評価点 = "5"
//            graph.評価点追加(評価: 5)
            print("5点")
            break
        case "4: 少し満足":
            user.user評価点 = "4"
//            graph.評価点追加(評価: 4)
            print("4点")
            break
        case "3: 普通":
            user.user評価点 = "3"
//            graph.評価点追加(評価: 3)
            print("3点")
            break
        case "2: 少し不満":
            user.user評価点 = "2"
//            graph.評価点追加(評価: 2)
            print("2点")
            break
        case "1: 不満":
            user.user評価点 = "1"
//            graph.評価点追加(評価: 1)
            print("1点")
            break
        default:
            user.user評価点 = ""
            print("評価未記入")
        }
        
        try! realm.write {
//            realm.delete(realm.objects(User.self))
            realm.add(user)
            print("results: \(results)")
        }
    }
       
    func showAlert() {
            let alertController = UIAlertController(title: "保存できません", message: "タイトルを入力してください", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
    }
    }
}
