//
//  GraphViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/10/30.
//

import UIKit
import Charts
import RealmSwift
import SwiftUI


class GraphViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var EpisodeTableView: UITableView!
    
    let edit = EpisodeDetailViewController()
//    let preview = PreviewEpisode()
    let update = EditEpisode()
    var chartView: LineChartView!
    var chartDataSet: LineChartDataSet!
    var sampleData:[Int] = []
    var ソート結果:[Int] = []
    var episodes = EditEpisode().EpisodeArray
    
    var タイトル: String = ""
    var 具体的に何をした: String = ""
    var 目標と困難: String = ""
    var 工夫した点: String = ""
    var 取り組んだ結果: String = ""
    var 活かせた長所: String = ""
    var 改善点: String = ""
    var 学んだこと: String = ""
    var 評価: String = ""
    var 日付: String = ""
    var id: String = ""
    
    @IBOutlet weak var Episode: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Episode.dataSource = self
        Episode.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Realm準備
        let realm = try! Realm()
        let userData = realm.objects(User.self)
        
        var sampleData:[Int] = []
        let sort_test = realm.objects(User.self).sorted(byKeyPath: "user日付", ascending: true)
        // グラフを表示する
        for i in 0 ..< userData.count{
            sampleData.append(Int(sort_test[i].user評価点) ?? 0)
        }
        
        print("<< viewWillAppear >>")
        displayChart(data: sampleData)
//        displayChartTest(data: sampleData)
        
        
      //テーブルを再描画
        Episode.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //データがあるだけセルを作る
        let userData = edit.realm.objects(User.self)
        return userData.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
//        let userData = edit.realm.objects(User.self)
        let realm = try! Realm()
        let sort_test = realm.objects(User.self).sorted(byKeyPath: "user日付", ascending: true)
        タイトル = sort_test[indexPath.row].userタイトル
        具体的に何をした = sort_test[indexPath.row].user具体的に何をした
        目標と困難 = sort_test[indexPath.row].user目標と困難
        工夫した点 = sort_test[indexPath.row].user工夫した点
        取り組んだ結果 = sort_test[indexPath.row].user取り組んだ結果
        活かせた長所 = sort_test[indexPath.row].user活かせた長所
        改善点 = sort_test[indexPath.row].user改善点
        学んだこと = sort_test[indexPath.row].user学んだこと
        日付 = sort_test[indexPath.row].user日付
        評価 = sort_test[indexPath.row].user評価点
        id = sort_test[indexPath.row].game_id
        performSegue(withIdentifier: "toPreviewEpisode", sender: nil)
    }
    
    //値渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if (segue.identifier == "toPreviewEpisode") {
                let editVC: PreviewEpisode = (segue.destination as? PreviewEpisode)!
                editVC.text_タイトル = タイトル
                editVC.text_具体的に何をした = 具体的に何をした
                editVC.text_目標と困難 = 目標と困難
                editVC.text_工夫した点 = 工夫した点
                editVC.text_取り組んだ結果 = 取り組んだ結果
                editVC.text_活かせた長所 = 活かせた長所
                editVC.text_改善点 = 改善点
                editVC.text_学んだこと = 学んだこと
                editVC.text_日付 = 日付
                editVC.text_評価 = 評価
                editVC.id = id
                print("@GraphViewController: ", id)
            }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath)
        let userData = edit.realm.objects(User.self)
        let realm = try! Realm()
        let sort_test = realm.objects(User.self).sorted(byKeyPath: "user日付", ascending: true)
        cell.textLabel?.numberOfLines=0
        
        cell.textLabel!.text = "\(sort_test[indexPath.row].user日付)\n[\(sort_test[indexPath.row].userタイトル)]"
        update.id = sort_test[indexPath.row].game_id
        PreviewEpisode().id = sort_test[indexPath.row].game_id
        print("更新update.id: ", userData[indexPath.row].game_id)
        return cell
    }
                        
    func displayChart(data: [Int]) {
        let realm = try! Realm()
//        let sort_test = realm.objects(User.self).sorted(byKeyPath: "user日付", ascending: true)
//
//        print("sort_test: [[ \(sort_test[0].user日付) ]]")
            // グラフの範囲を指定する
        chartView = LineChartView(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: 230))

            // プロットデータ(y軸)を保持する配列
            var dataEntries = [ChartDataEntry]()
            
            for (xValue, yValue) in data.enumerated() {
                let dataEntry = ChartDataEntry(x: Double(xValue), y: Double(yValue))
                dataEntries.append(dataEntry)
            }
            // グラフにデータを適用
            chartDataSet = LineChartDataSet(entries: dataEntries, label: "SampleDataChart")
            chartDataSet.lineWidth = 5.0 // グラフの線の太さを変更
            chartDataSet.mode = .cubicBezier // 滑らかなグラフの曲線にする
            chartDataSet.colors =  [UIColor(red: 185/255, green: 255/255, blue: 248/255, alpha: 1.0)]//線の色
            chartDataSet.circleColors = [UIColor(red: 111/255, green: 237/255, blue: 214/255, alpha: 1.0)]//点の色
        //背景色
            chartView.gridBackgroundColor = UIColor(red: 0.23, green: 0.24, blue: 0.21, alpha: 1.0)
            chartView.data = LineChartData(dataSet: chartDataSet)
            
            // X軸(xAxis)
//            chartView.xAxis.labelPosition = .bottom // x軸ラベルをグラフの下に表示する
        chartView.xAxis.enabled = false //x軸ラベル非表示
            // Y軸(leftAxis/rightAxis)
            chartView.leftAxis.axisMaximum = 5 //y左軸最大値
            chartView.leftAxis.axisMinimum = 1 //y左軸最小値
            chartView.leftAxis.labelCount = 4 // y軸ラベルの数
            chartView.rightAxis.enabled = false // 右側の縦軸ラベルを非表示
            
            // その他の変更
            chartView.highlightPerTapEnabled = false // プロットをタップして選択不可
            chartView.legend.enabled = false // グラフ名（凡例）を非表示
            chartView.pinchZoomEnabled = false // ピンチズーム不可
            chartView.doubleTapToZoomEnabled = false // ダブルタップズーム不可
            chartView.extraTopOffset = 20 // 上から20pxオフセットすることで上の方にある値(99.0)を表示する
            
            chartView.animate(xAxisDuration: 1) // 1秒かけて左から右にグラフをアニメーションで表示する

            // 指を離してもスクロールが続くか
            chartView.dragDecelerationEnabled = true

            // 指を離してからの自動スクロールの減速度合い(0~1)
            chartView.dragDecelerationFrictionCoef = 0.9
            // データがない時に表示するテキスト
            chartView.noDataText = "No chart data available."
        
            chartView.removeFromSuperview()
            view.addSubview(chartView)
        }
    
}
