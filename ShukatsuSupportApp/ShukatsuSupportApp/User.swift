//
//  User.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/21.
//

import Foundation
import RealmSwift

class User: Object {
    //項目追加時は一回アンインストール
    @objc dynamic var userタイトル = ""
    @objc dynamic var user具体的に何をした = ""
    @objc dynamic var user目標と困難 = ""
    @objc dynamic var user工夫した点 = ""
    @objc dynamic var user取り組んだ結果 = ""
    @objc dynamic var user活かせた長所 = ""
    @objc dynamic var user改善点 = ""
    @objc dynamic var user学んだこと = ""
    @objc dynamic var user日付 = ""
    @objc dynamic var user評価点 = ""
    
    
    @objc dynamic var userなぜなぜ1 = ""
    @objc dynamic var userなぜなぜ2 = ""
    @objc dynamic var userなぜなぜ3 = ""
    @objc dynamic var userなぜなぜ4 = ""
    @objc dynamic var userなぜなぜ5 = ""
    
    @objc dynamic var user文章作成_結論 = ""
    @objc dynamic var user文章作成_動機 = ""
    @objc dynamic var user文章作成_目標と困難 = ""
    @objc dynamic var user文章作成_取り組みと結果 = ""
    @objc dynamic var user文章作成_人柄 = ""
    @objc dynamic var user文章作成_学び = ""
    
    @objc dynamic var game_id = UUID().uuidString
    
    override static func primaryKey() -> String? {
        return "game_id"
    }
}
