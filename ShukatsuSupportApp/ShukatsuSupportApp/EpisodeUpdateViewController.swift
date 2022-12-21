//
//  EpisodeUpdateViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/12/21.
//

import UIKit

class EpisodeUpdateViewController: UIViewController {
    @IBOutlet weak var タイトル : UITextField!
    @IBOutlet weak var 日付: UILabel!
    @IBOutlet weak var 評価: UILabel!
    @IBOutlet weak var 具体的に何をした: UITextView!
    @IBOutlet weak var 目標と困難: UITextView!
    @IBOutlet weak var 工夫した点: UITextView!
    @IBOutlet weak var 取り組んだ結果: UITextView!
    @IBOutlet weak var 活かせた長所: UITextView!
    @IBOutlet weak var 改善点: UITextView!
    @IBOutlet weak var 学んだこと: UITextView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        タイトル.text = text_タイトル
        日付.text = text_日付
        評価.text = text_評価
        具体的に何をした.text  = text_具体的に何をした
        目標と困難.text  = text_目標と困難
        工夫した点.text  = text_工夫した点
        取り組んだ結果.text  = text_取り組んだ結果
        活かせた長所.text  = text_活かせた長所
        改善点.text  = text_改善点
        学んだこと.text  = text_学んだこと
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
