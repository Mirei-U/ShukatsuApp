//
//  EditWritingViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/12/05.
//

import UIKit
import RealmSwift

class PreviewWritingViewController: UIViewController {

    //Realmを使うときのお決まりのやつ
    let realm = try! Realm()
    let editES = EditWritingViewController()
    let preview = PreviewEpisode()
    @IBOutlet weak var 結論: UITextView!
    @IBOutlet weak var 動機: UITextView!
    @IBOutlet weak var 目標と困難: UITextView!
    @IBOutlet weak var 取り組みと結果: UITextView!
    @IBOutlet weak var 人柄: UITextView!
    @IBOutlet weak var 学び: UITextView!
    
    @IBOutlet weak var 対象１: UILabel!
    @IBOutlet weak var 対象２: UILabel!
    @IBOutlet weak var 対象３: UILabel!
    @IBOutlet weak var 対象４: UILabel!
    @IBOutlet weak var 対象５: UILabel!
    @IBOutlet weak var 対象６: UILabel!
    
    
    var id: String = ""
    

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
            let targetUser = realm.object(ofType: User.self, forPrimaryKey: id)
            結論.text = targetUser!.user文章作成_結論
            動機.text = targetUser!.user文章作成_動機
            目標と困難.text = targetUser!.user文章作成_目標と困難
            取り組みと結果.text = targetUser!.user文章作成_取り組みと結果
            人柄.text = targetUser!.user文章作成_人柄
            学び.text = targetUser!.user文章作成_学び
        
    }
    
    @IBAction func pushButton(_ sender: UIButton) {
        // 文字列によるクエリ
        let targetUser = realm.object(ofType: User.self, forPrimaryKey: id)
        switch sender.restorationIdentifier{
        case "1":
            editES.text_文章作成対象 = 対象１.text!
            editES.text_文章作成対象中身 = targetUser!.user文章作成_結論
            editES.text_参照テーマ1 = "エピソードのタイトル"
            editES.text_参照テーマ2 = "具体的に何をした"
            editES.text_参照テーマ1中身 = targetUser!.userタイトル
            editES.text_参照テーマ2中身 = targetUser!.user具体的に何をした
            editES.質問番号 = "1"
            performSegue(withIdentifier: "toEditWriting", sender: nil)
            break
        case "2":
            editES.text_文章作成対象 = 対象２.text!
            editES.text_文章作成対象中身 = targetUser!.user文章作成_動機
            editES.text_参照テーマ1 = "なぜなぜ分析"
            var text1: String = "<未入力の項目です>"
            var text2: String = "<未入力の項目です>"
            var text3: String = "<未入力の項目です>"
            var text4: String = "<未入力の項目です>"
            var text5: String = "<未入力の項目です>"
            if(targetUser?.userなぜなぜ1 != nil){
                text1 = targetUser!.userなぜなぜ1
            }
            if(targetUser?.userなぜなぜ2 != nil){
                text2 = targetUser!.userなぜなぜ2
            }
            if(targetUser?.userなぜなぜ3 != nil){
                text3 = targetUser!.userなぜなぜ3
            }
            if(targetUser?.userなぜなぜ4 != nil){
                text4 = targetUser!.userなぜなぜ4
            }
            if(targetUser?.userなぜなぜ5 != nil){
                text5 = targetUser!.userなぜなぜ5
            }
            editES.text_参照テーマ1中身 = "Q1. この時どんな感情だった?\n\(text1)\n\nQ2.なぜそう思った?\n\(text2)\n\nQ3.それはなぜ?\n\(text3)\n\nQ4.それはなぜ?\n\(text4)\n\nQ5.それはなぜ?\n\(text5)"
            editES.質問番号 = "2"
            performSegue(withIdentifier: "toEditWriting", sender: nil)
            break
        case "3":
            editES.text_文章作成対象 = 対象３.text!
            editES.text_文章作成対象中身 = targetUser!.user文章作成_目標と困難
            editES.text_参照テーマ1 = "目標と困難"
            editES.text_参照テーマ1中身 = targetUser!.user目標と困難
            editES.text_参照テーマ2中身 = targetUser!.user具体的に何をした
            editES.質問番号 = "3"
            performSegue(withIdentifier: "toEditWriting", sender: nil)
            break
        case "4":
            editES.text_文章作成対象 = 対象４.text!
            editES.text_文章作成対象中身 = targetUser!.user文章作成_取り組みと結果
            editES.text_参照テーマ1 = "工夫した点"
            editES.text_参照テーマ2 = "取り組んだ結果"
            editES.text_参照テーマ1中身 = targetUser!.user工夫した点
            editES.text_参照テーマ2中身 = targetUser!.user取り組んだ結果
            editES.質問番号 = "4"
            performSegue(withIdentifier: "toEditWriting", sender: nil)
            break
        case "5":
            editES.text_文章作成対象 = 対象５.text!
            editES.text_文章作成対象中身 = targetUser!.user文章作成_人柄
            editES.text_参照テーマ1 = "活かせた長所・強み"
            editES.text_参照テーマ2 = "なぜなぜ分析"
            editES.text_参照テーマ1中身 = targetUser!.user活かせた長所
            editES.質問番号 = "5"
//            editES.text_参照テーマ2中身 = targetUser!.user具体的に何をした
            performSegue(withIdentifier: "toEditWriting", sender: nil)
            break
        case "6":
            editES.text_文章作成対象 = 対象６.text!
            editES.text_文章作成対象中身 = targetUser!.user文章作成_学び
            editES.text_参照テーマ1 = "改善点"
            editES.text_参照テーマ2 = "学んだこと"
            editES.text_参照テーマ1中身 = targetUser!.user改善点
            editES.text_参照テーマ2中身 = targetUser!.user学んだこと
            editES.質問番号 = "6"
            performSegue(withIdentifier: "toEditWriting", sender: nil)
            break
        default:
            break
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditWriting" {
            let nextView = segue.destination as! EditWritingViewController
            nextView.text_文章作成対象 = editES.text_文章作成対象
            nextView.text_文章作成対象中身 = editES.text_文章作成対象中身
            nextView.text_参照テーマ1 = editES.text_参照テーマ1
            nextView.text_参照テーマ2 = editES.text_参照テーマ2
            nextView.text_参照テーマ1中身 = editES.text_参照テーマ1中身
            nextView.text_参照テーマ2中身 = editES.text_参照テーマ2中身
            nextView.id = id
            nextView.質問番号 = editES.質問番号
        }
    }
}
