//
//  ESwritingViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/07.
//

import UIKit

class ESwritingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let edit = EpisodeDetailViewController()
    @IBOutlet var EpisodeTableView: UITableView!
    @IBOutlet weak var ESLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ESLabel.text = "エピソードを下の一覧から選択しよう。\n赤く表示されている部分がおすすめ！"
        EpisodeTableView.dataSource = self
        EpisodeTableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let userData = edit.realm.objects(User.self)
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //セル取得
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath)
        let userData = edit.realm.objects(User.self)
        //セル表示内容設定
        cell.textLabel!.text = "[タイトル：\(userData[indexPath.row].userタイトル)]"
        return cell
    }
    
}
