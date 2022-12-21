//
//  EpisodeDetailViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/11.
//

import UIKit

class PreviewEpisode: UIViewController {

//    var Episode: EpisodeInfo!
    
    let edit = EpisodeDetailViewController()
    let graph = GraphViewController()
   
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
    
//    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        タイトル.text = text_タイトル
        日付.text = ""
        評価.text=""
        具体的に何をした.text  = ""
        目標と困難.text  = ""
        工夫した点.text  = ""
        取り組んだ結果.text  = ""
        活かせた長所.text  = ""
        改善点.text  = ""
        学んだこと.text  = ""
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }

}
