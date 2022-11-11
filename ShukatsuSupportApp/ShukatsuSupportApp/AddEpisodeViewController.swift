//
//  AddEpisodeViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/10.
//

import UIKit

class AddEpisodeViewController: UIViewController{
    
    
    @IBOutlet weak var タイトル : UITextField!
    @IBOutlet weak var 具体的に何をした: UITextView!
    @IBOutlet weak var 目標と困難: UITextView!
    @IBOutlet weak var 工夫した点: UITextView!
    @IBOutlet weak var 取り組んだ結果: UITextView!
    @IBOutlet weak var 活かせた長所: UITextView!
    @IBOutlet weak var 改善点: UITextView!
    @IBOutlet weak var 学んだこと: UITextView!

    
    var 編集前_タイトル = ""
    var 編集前_具体的に何をした = ""
    var 編集前_目標と困難 = ""
    var 編集前_工夫した点 = ""
    var 編集前_取り組んだ結果 = ""
    var 編集前_活かせた長所 = ""
    var 編集前_改善点 = ""
    var 編集前_学んだこと = ""
    
    //userdefaultインスタンス
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func save() {
        編集前_タイトル = タイトル.text!
        編集前_具体的に何をした = 具体的に何をした.text!
        編集前_目標と困難 = 目標と困難.text!
        編集前_工夫した点 = 工夫した点.text!
        編集前_取り組んだ結果 = 取り組んだ結果.text!
        編集前_活かせた長所 = 活かせた長所.text!
        編集前_改善点 = 改善点.text!
        編集前_学んだこと = 学んだこと.text!
    }
    
    }
