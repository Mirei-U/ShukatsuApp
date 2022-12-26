//
//  EpisodeDetailViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/11.
//

import UIKit

class PreviewEpisode: UIViewController, EditViewControllerDelegate {

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
    @IBOutlet weak var 編集する: UIBarButtonItem!
    
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

    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    
    @IBAction func tapEditButton(sender: UIButton) {
        let view = storyboard?.instantiateViewController(withIdentifier: "editViewController") as! EpisodeDetailViewController
        view.タイトル = タイトル
        view.delegate = self
        present(view, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let DetailVC: EpisodeDetailViewController = (segue.destination as? EpisodeDetailViewController)!
                DetailVC.text_タイトル = タイトル.text!
                DetailVC.text_具体的に何をした = 具体的に何をした.text!
                DetailVC.text_目標と困難 = 目標と困難.text!
                DetailVC.text_工夫した点 = 工夫した点.text!
                DetailVC.text_取り組んだ結果 = 取り組んだ結果.text!
                DetailVC.text_活かせた長所 = 活かせた長所.text!
                DetailVC.text_改善点 = 改善点.text!
                DetailVC.text_学んだこと = 学んだこと.text!
                DetailVC.text_日付 = 日付.text!
                DetailVC.text_評価 = 評価.text!
    }
    func editDidFinished(modalText text: String?){
        タイトル.text = text
    }
}
