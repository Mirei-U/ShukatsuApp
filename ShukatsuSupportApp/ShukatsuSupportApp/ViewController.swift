//
//  ViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/10/28.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var addTextView: UITextView!
    @IBOutlet weak var textViewShow: UITextView!
    @IBOutlet weak var button: UIButton!
    
    //userdefaultインスタンス
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //起動時にユーザーデフォルトを書き込む
        textViewShow.text = textViewData()
        
        //これ書くと、最下部のextensionとつながる
        addTextView.delegate = self
        
        //起動時はボタン使えない
        button.isEnabled = false
        button.setTitleColor(UIColor.systemGray , for: .normal)
        
        //キーボード入力処理を受け取るコマンド
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        //キーボードを隠す処理を受け取るコマンド
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //UserDefaultsから値を読み込む
    @objc func textViewData() -> String {
        return userDefaults.object(forKey: "textKey") as? String ?? ""
    }
    
    //キーボードを消す
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //キーボードを表示するときに画面をずらす動作
    @objc func showKeyboard(notification: Notification) {
        let keyboardFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        
        guard let keyboardMinY = keyboardFrame?.minY else{ return }
        let buttonMaxY = button.frame.maxY
        let distance = buttonMaxY - keyboardMinY + 500  //この"200"が画面タテ方向への移動量
        let transform = CGAffineTransform(translationX: 0, y: -distance)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: []
                       , animations: {
                        self.view.transform = transform})
    }
    
    //キーボード消える時に画面の位置を元に戻す動作
    @objc func hideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: []
                       , animations: {
                        self.view.transform = .identity}) //これでキーボードが下に戻る時に画面が下に戻る
    }
    
    
    //buttonを押した時の動作
    @IBAction func button(_ sender: Any) {
        
        self.userDefaults.set(self.addTextView.text, forKey: "textKey")
        
        guard let Text = self.addTextView.text else { return }
        
        //テキストビューに表示
        self.textViewShow.text = Text
        //TextViewに空文字を入れて空白にする
        self.addTextView.text = ""
        //keyboardを隠す
        self.dismissKeyboard()
    }
    
    //buttonが押されたらキーボードを消す
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
}


//textViewに、テキストがあるか無いかを判別してる
extension ViewController: UITextViewDelegate {
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        let addTextViewEmpty = addTextView.text?.isEmpty ?? true
        if addTextViewEmpty  {
            button.isEnabled = false
            button.setTitleColor(UIColor.systemGray , for: .normal)
        } else {
            button.isEnabled = true
            button.setTitleColor(UIColor.white , for: .normal)
            
        }
    }
}
