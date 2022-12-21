//
//  EpisodeTableViewCell.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/12/18.
//

import UIKit
import RealmSwift
class EpisodeTableViewCell: UITableViewCell{

    
   

    @IBOutlet weak var 日付: UILabel!
    @IBOutlet weak var タイトル: UILabel!
    
    
    let edit = EpisodeDetailViewController()
    let realm = try! Realm()
    
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
     
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
     
            // Configure the view for the selected state
        }
     
        /// 画像・タイトル・説明文を設定するメソッド
        func setCell(dateText: String, titleText: String) {
            日付.text = dateText
            タイトル.text = titleText
        }
}
