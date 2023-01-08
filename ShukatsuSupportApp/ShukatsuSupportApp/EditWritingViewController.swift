//
//  EditWritingViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2023/01/05.
//

import UIKit
import RealmSwift
import SwiftUI

class EditWritingViewController: UIViewController {
    
    @IBOutlet var 文章作成対象: UILabel!
    @IBOutlet var 参照テーマ1: UILabel!
    @IBOutlet var 参照テーマ2: UILabel!
    @IBOutlet weak var 文章作成対象中身: UITextView!
    @IBOutlet weak var 参照テーマ1中身: UITextView!
    @IBOutlet weak var 参照テーマ2中身: UITextView!
    
    var text_文章作成対象: String = ""
    var text_文章作成対象中身: String = ""
    var text_参照テーマ1: String = ""
    var text_参照テーマ2: String = ""
    var text_参照テーマ1中身: String = ""
    var text_参照テーマ2中身: String = ""
    var id: String = ""
    var 質問番号: String = ""

    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        文章作成対象.text = text_文章作成対象
        文章作成対象中身.text = text_文章作成対象中身
        参照テーマ1.text = text_参照テーマ1
        参照テーマ2.text = text_参照テーマ2
        参照テーマ1中身.text = text_参照テーマ1中身
        参照テーマ2中身.text = text_参照テーマ2中身
        print(id)
    }
    
    @IBAction func 保存(_ sender: Any) {

        //グラフ画面に戻る
        self.navigationController?.popToViewController(navigationController!.viewControllers[2], animated: true)
        print("⏪戻る")
        do{
            try realm.write {
                let targetUser = realm.object(ofType: User.self, forPrimaryKey: id)
                print("🔺realm.write: \(id)")
                switch 質問番号{
                case "1":
                    targetUser?.user文章作成_結論 = 文章作成対象中身.text!
                    break
                case "2":
                    targetUser!.user文章作成_動機 = 文章作成対象中身.text!
                    break
                case "3":
                    targetUser!.user文章作成_目標と困難 = 文章作成対象中身.text!
                    break
                case "4":
                    targetUser!.user文章作成_取り組みと結果 = 文章作成対象中身.text!
                    break
                case "5":
                    targetUser!.user文章作成_人柄 = 文章作成対象中身.text!
                    break
                case "6":
                    targetUser!.user文章作成_学び = 文章作成対象中身.text!
                    break
                default:
                    break
                }
            }
        }catch {
          print("Error \(error)")
        }
    }
}
    
