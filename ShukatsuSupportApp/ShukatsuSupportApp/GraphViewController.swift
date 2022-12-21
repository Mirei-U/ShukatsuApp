//
//  GraphViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/10/30.
//

import UIKit
import Charts
import RealmSwift


//struct EpisodeInfo{
//    var タイトル: String
//    var 具体的に何をした: String
//    var 目標と困難: String
//    var 工夫した点: String
//    var 取り組んだ結果: String
//    var 活かせた長所: String
//    var 改善点: String
//    var 学んだこと: String
//    var 評価: String
//    var 日付: String
//}
class GraphViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var EpisodeTableView: UITableView!
    
    let edit = EpisodeDetailViewController()
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
        // グラフを表示する
        for i in 0 ..< userData.count{
            sampleData.append(Int(userData[i].user評価点) ?? 0)
        }
        
        print("<< viewWillAppear >>")
        displayChart(data: sampleData)
//        displayChartTest(data: sampleData)
        
        let sorte = realm.objects(User.self).sorted(byKeyPath: "userタイトル", ascending: true)
        print("ソート結果: \(sorte)")
      //テーブルを再描画
        Episode.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //データがあるだけセルを作る
        let userData = edit.realm.objects(User.self)
        return userData.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("選択されたセルのセクション番号は\(indexPath.section)です。")
        print("選択されたセルのRow番号は\(indexPath.row)です。")
        
        let userData = edit.realm.objects(User.self)
//        guard let PreviewEpisodeController = storyboard?.instantiateViewController(identifier: "EpisodeView") as? PreviewEpisode else { return }
//        PreviewEpisodeController.タイトル.text = userData[indexPath.row].userタイトル
//        self.performSegue(withIdentifier: "toPreviewEpisode", sender: nil)
        タイトル = userData[indexPath.row].userタイトル
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
            }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath)
        let userData = edit.realm.objects(User.self)
        cell.textLabel!.text = "[タイトル：\(userData[indexPath.row].userタイトル)]"
        let results = edit.realm.objects(User.self).sorted(byKeyPath: "user日付", ascending: false)
        print(results)
        return cell
    }
                        
    func displayChart(data: [Int]) {
        print("<< displayChart >>")
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
        
        //背景色
            chartView.gridBackgroundColor = UIColor(red: 0.23, green: 0.24, blue: 0.21, alpha: 1.0)
            chartView.data = LineChartData(dataSet: chartDataSet)
            // X軸(xAxis)
            chartView.xAxis.labelPosition = .bottom // x軸ラベルをグラフの下に表示する
            
            // Y軸(leftAxis/rightAxis)
            chartView.leftAxis.axisMaximum = 5 //y左軸最大値
            chartView.leftAxis.axisMinimum = 0 //y左軸最小値
            chartView.leftAxis.labelCount = 5 // y軸ラベルの数
            chartView.rightAxis.enabled = false // 右側の縦軸ラベルを非表示
            
            // その他の変更
            chartView.highlightPerTapEnabled = false // プロットをタップして選択不可
            chartView.legend.enabled = false // グラフ名（凡例）を非表示
            chartView.pinchZoomEnabled = false // ピンチズーム不可
            chartView.doubleTapToZoomEnabled = false // ダブルタップズーム不可
            chartView.extraTopOffset = 20 // 上から20pxオフセットすることで上の方にある値(99.0)を表示する
            
            chartView.animate(xAxisDuration: 1) // 2秒かけて左から右にグラフをアニメーションで表示する
        
        chartView.removeFromSuperview()
            view.addSubview(chartView)
        }
    
}
