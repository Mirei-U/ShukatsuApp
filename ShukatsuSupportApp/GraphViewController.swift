//
//  GraphViewController.swift
//  ShukatsuSupportApp
//
//  Created by 内田光玲 on 2022/10/30.
//

import UIKit
import Charts

class GraphViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    var chartView: LineChartView!
    var chartDataSet: LineChartDataSet!
    // 今回使用するサンプルデータ
    let sampleData = [3.0,3.0,3.0,4.0,4.0,5.0,5.0,5.0,2.0]
    //cellに表示する内容(仮)
    let episodes = ["test","test2","test3"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // グラフを表示する
                displayChart(data: sampleData)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell",for: indexPath)
        cell.textLabel!.text=episodes[indexPath.row]
        return cell
    }
    func displayChart(data: [Double]) {
            // グラフの範囲を指定する
        chartView = LineChartView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 230))
            // プロットデータ(y軸)を保持する配列
            var dataEntries = [ChartDataEntry]()
            
            for (xValue, yValue) in data.enumerated() {
                let dataEntry = ChartDataEntry(x: Double(xValue), y: yValue)
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
