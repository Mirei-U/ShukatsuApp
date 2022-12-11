//
//  NazeNazeViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/11/07.
//

import UIKit
import Charts
import RealmSwift

class NazeNazeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    let edit = EpisodeDetailViewController()
    var chartView: LineChartView!
    var chartDataSet: LineChartDataSet!
    var sampleData:[Int] = []
    
    @IBOutlet var EpisodeTableView: UITableView!
    @IBOutlet weak var NazeNazeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NazeNazeLabel.text = "エピソードを下の一覧から選択しよう。\n赤く表示されている部分がおすすめ！"
        
        EpisodeTableView.dataSource = self
        EpisodeTableView.delegate = self
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
        displayChart(data: sampleData)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //データがあるだけセルを作る
        let userData = edit.realm.objects(User.self)
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath)
        let userData = edit.realm.objects(User.self)
        cell.textLabel!.text = "[タイトル：\(userData[indexPath.row].userタイトル)]"
        return cell
    }
    
    func displayChart(data: [Int]) {
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
        
            chartView.gridBackgroundColor = UIColor(red: 1, green: 0.6, blue: 0.3, alpha: 1.0)
            
        
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
            
            chartView.animate(xAxisDuration: 2) // 2秒かけて左から右にグラフをアニメーションで表示する
            
            view.addSubview(chartView)
        }

}
