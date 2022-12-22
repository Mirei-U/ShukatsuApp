//
//  ViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/10/28.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet  var グラフ作成: UIButton!
    @IBOutlet  var なぜなぜ分析: UIButton!
    @IBOutlet  var 文章作成: UIButton!
    //userdefaultインスタンス
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        影付きボタン(button: グラフ作成)
        影付きボタン(button: なぜなぜ分析)
        影付きボタン(button: 文章作成)
    }
    
    @IBAction func グラフ作成タップ(_ sender: Any) {
        if self.グラフ作成.backgroundColor == UIColor.white {
                グラフ作成.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
        }
    }
    @IBAction func なぜなぜタップ(_ sender: Any) {
        if self.なぜなぜ分析.backgroundColor == UIColor.white {
                なぜなぜ分析.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
        }
    }
    
    @IBAction func 文章作成タップ(_ sender: Any) {
        if self.文章作成.backgroundColor == UIColor.white {
                文章作成.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
        }
    }
    
    func 影付きボタン(button: UIButton){
    // 1.角丸設定
    // UIButtonの変数名.layer.cornerRadius = 角丸の大きさ
        button.layer.cornerRadius = 10
    // 影の濃さ
        button.layer.shadowOpacity = 0.7
    // 影のぼかしの大きさ
        button.layer.shadowRadius = 3
    // 影の色
        button.layer.shadowColor = UIColor.black.cgColor
    // 影の方向（width=右方向、height=下方向）
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}

