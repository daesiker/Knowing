//
//  ChartView.swift
//  Knowing
//
//  Created by Jun on 2021/11/20.
//

import Foundation
import UIKit
import Charts

class AqiChartView: BarChartView {
    
    var category:[String] = ["학생", "취업", "창업", "주거\n금융", "생활\n복지", "코로나\n19"]
    var unit:[Double] = [20.0, 15.0, 10.0, 5.0, 0.0, 0.0]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setChart(dataPoints: category, values: unit)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries:[BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i] + 1.0)
            
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries)
        chartDataSet.colors = [ UIColor.rgb(red: 255, green: 228, blue: 182), UIColor.rgb(red: 255, green: 176, blue: 128), UIColor.rgb(red: 255, green: 176, blue: 97), UIColor.rgb(red: 255, green: 142, blue: 59), UIColor.rgb(red: 255, green: 136, blue: 84), UIColor.rgb(red: 210, green: 132, blue: 81)]
        chartDataSet.highlightEnabled = false
        //chartDataSet.valueColors = [.clear]
        
        chartDataSet.drawValuesEnabled = true
        chartDataSet.drawIconsEnabled = true
        
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.4
        
        
        self.doubleTapToZoomEnabled = false
        self.data = chartData
        self.rightAxis.enabled = false
        self.leftAxis.enabled = false
        
        self.xAxis.labelPosition = .bottom
        self.xAxis.valueFormatter = IndexAxisValueFormatter(values: category)
        self.xAxis.labelFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)!
        self.xAxis.labelTextColor = UIColor.rgb(red: 102, green: 102, blue: 102)
        self.xAxis.drawAxisLineEnabled = false
        self.xAxis.drawGridLinesEnabled = false
        
        self.minOffset = 14
        self.legend.enabled = false
        self.drawValueAboveBarEnabled = true
        
        
        
        for i in 0..<chartDataSet.count {
            
            let position = self.getPosition(entry: dataEntries[i], axis: .left)
            
            let imgView = UIImageView(image: UIImage(named: "chartIndicator")!)
            imgView.frame = CGRect(x: position.x, y: position.y, width: 25, height: 28)
            self.addSubview(imgView)
        }
        
    }
    
    
    
}
