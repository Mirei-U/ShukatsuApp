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
    
    var タイトル: String = ""
    var なぜなぜ1:String = ""
    var なぜなぜ2:String = ""
    var なぜなぜ3:String = ""
    var なぜなぜ4:String = ""
    var なぜなぜ5:String = ""
    var id:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NazeNazeLabel.text = "なぜなぜ分析をしたいエピソードを下の一覧から選択しよう。"
        
        EpisodeTableView.dataSource = self
        EpisodeTableView.delegate = self
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
        displayChart(data: sampleData)
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
        なぜなぜ1 = sort_test[indexPath.row].userなぜなぜ1
        なぜなぜ2 = sort_test[indexPath.row].userなぜなぜ2
        なぜなぜ3 = sort_test[indexPath.row].userなぜなぜ3
        なぜなぜ4 = sort_test[indexPath.row].userなぜなぜ4
        なぜなぜ5 = sort_test[indexPath.row].userなぜなぜ5
        id = sort_test[indexPath.row].game_id
        performSegue(withIdentifier: "toNazeNaze", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let NazeNazeVC: NazeNazeQuestionViewController = (segue.destination as? NazeNazeQuestionViewController)!
        NazeNazeVC.text_タイトル = タイトル
        NazeNazeVC.text_なぜなぜ1 = なぜなぜ1
        NazeNazeVC.text_なぜなぜ2 = なぜなぜ2
        NazeNazeVC.text_なぜなぜ3 = なぜなぜ3
        NazeNazeVC.text_なぜなぜ4 = なぜなぜ4
        NazeNazeVC.text_なぜなぜ5 = なぜなぜ5
        NazeNazeVC.id = id
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath)
//        let userData = edit.realm.objects(User.self)
        let realm = try! Realm()
        let sort_test = realm.objects(User.self).sorted(byKeyPath: "user日付", ascending: true)
        cell.textLabel?.numberOfLines=0
        cell.textLabel!.text = "\(sort_test[indexPath.row].user日付)\n[\(sort_test[indexPath.row].userタイトル)]"
        return cell
    }

    func displayChart(data: [Int]) {
//        let realm = try! Realm()
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
            chartDataSet.colors =  [UIColor(red: 255/255, green: 230/255, blue: 154/255, alpha: 1.0)]//線の色
            chartDataSet.circleColors = [UIColor(red: 255/255, green: 210/255, blue: 76/255, alpha: 1.0)]//点の色
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
        
        chartView.removeFromSuperview()
            view.addSubview(chartView)
        }

}
