//
//  User.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/21.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var userタイトル = ""
    @objc dynamic var user具体的に何をした = ""
    @objc dynamic var user目標と困難 = ""
    @objc dynamic var user工夫した点 = ""
    @objc dynamic var user取り組んだ結果 = ""
    @objc dynamic var user活かせた長所 = ""
    @objc dynamic var user改善点 = ""
    @objc dynamic var user学んだこと = ""
}