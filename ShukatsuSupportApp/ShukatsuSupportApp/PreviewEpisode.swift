//
//  EpisodeDetailViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/11.
//

import UIKit

class PreviewEpisode: UIViewController {
    
    
    let edit = EditEpisode()
    
    @IBOutlet weak var タイトル : UITextField!
    @IBOutlet weak var 具体的に何をした: UITextView!
    @IBOutlet weak var 目標と困難: UITextView!
    @IBOutlet weak var 工夫した点: UITextView!
    @IBOutlet weak var 取り組んだ結果: UITextView!
    @IBOutlet weak var 活かせた長所: UITextView!
    @IBOutlet weak var 改善点: UITextView!
    @IBOutlet weak var 学んだこと: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
//        edit.removeUserDefaults()
        
        let 保存済みタイトル = UserDefaults.standard.string(forKey: "タイトルキー")
        let 保存済み具体的 = UserDefaults.standard.string(forKey: "具体的キー")
        let 保存済み目標 = UserDefaults.standard.string(forKey: "目標キー")
        let 保存済み工夫 = UserDefaults.standard.string(forKey: "工夫キー")
        let 保存済み結果 = UserDefaults.standard.string(forKey: "結果キー")
        let 保存済み長所 = UserDefaults.standard.string(forKey: "長所キー")
        let 保存済み改善点 = UserDefaults.standard.string(forKey: "改善点キー")
        let 保存済み学んだこと = UserDefaults.standard.string(forKey: "学んだことキー")
        タイトル.text = 保存済みタイトル
        具体的に何をした.text  = 保存済み具体的
        目標と困難.text  = 保存済み目標
        工夫した点.text  = 保存済み工夫
        取り組んだ結果.text  = 保存済み結果
        活かせた長所.text  = 保存済み長所
        改善点.text  = 保存済み改善点
        学んだこと.text  = 保存済み学んだこと
    }
    



}
