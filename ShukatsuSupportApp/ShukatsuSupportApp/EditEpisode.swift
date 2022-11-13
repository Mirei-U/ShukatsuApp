//
//  AddEpisodeViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/10.
//

import UIKit

class EditEpisode: UIViewController{
    
    @IBOutlet weak var タイトル : UITextField!
    @IBOutlet weak var 具体的に何をした: UITextView!
    @IBOutlet weak var 目標と困難: UITextView!
    @IBOutlet weak var 工夫した点: UITextView!
    @IBOutlet weak var 取り組んだ結果: UITextView!
    @IBOutlet weak var 活かせた長所: UITextView!
    @IBOutlet weak var 改善点: UITextView!
    @IBOutlet weak var 学んだこと: UITextView!

    public var EpisodeArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        removeUserDefaults()
        
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
    
    //userdefaultインスタンス
    let userDefaults = UserDefaults.standard
    
    @IBAction func 保存ボタン(_ sender: Any) {

        UserDefaults.standard.set(タイトル.text!, forKey: "タイトルキー")
        UserDefaults.standard.set(具体的に何をした.text!, forKey: "具体的キー")
        UserDefaults.standard.set(目標と困難.text!, forKey: "目標キー")
        UserDefaults.standard.set(工夫した点.text!, forKey: "工夫キー")
        UserDefaults.standard.set(取り組んだ結果.text!, forKey: "結果キー")
        UserDefaults.standard.set(活かせた長所.text!, forKey: "長所キー")
        UserDefaults.standard.set(改善点.text!, forKey: "改善点キー")
        UserDefaults.standard.set(学んだこと.text!, forKey: "学んだことキー")
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func removeUserDefaults() {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }
    
    }
