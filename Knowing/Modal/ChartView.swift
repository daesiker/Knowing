//
//  ChartView.swift
//  Knowing
//
//  Created by Jun on 2021/11/20.
//

import Foundation
import UIKit
import Macaw

import Foundation
import UIKit
import Macaw

class AqiChartView: MacawView {
    
    static var aqiBars = createData()
    
    static let maxValue = 200
    static let maxValueLineHeight = 200
    static let lineWidth: Double = 400
    
    static let dataDivisor = Double(maxValue/maxValueLineHeight)
    static let adjustedData: [Double] = aqiBars.map({ $0.aqiIndex / dataDivisor }) // $0 : each item
    static var animations: [Animation] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @objc required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private static func createChart() -> Group { // group : array of nodes
        var items:[Node] = addYAxisItems() + addXAxisItems()
        items.append(createBars())
        
        return Group(contents: items, place: .identity)
    }
    
    private static func addYAxisItems() -> [Node]{
        let maxLines = 6
        let yAxisHeight: Double = 200
        let lineSpacing: Double = 30
        
        var newNodes: [Node] = []
        
        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * lineSpacing)
            let valueLine = Line(x1: -5, y1: y, x2: lineWidth, y2: y).stroke(fill: Color.white)
            newNodes.append(valueLine)
        }
        
        return newNodes
    }
    
    private static func addXAxisItems() -> [Node]{
        let chartBaseY: Double = 200
        var newNodes: [Node] = []
        
        for i in 1...adjustedData.count {
            let x = (Double(i) * 50) // start
            let valueText = Text(text: aqiBars[i-1].time, align: .max, baseline: .mid, place: .move(dx: x-8, dy: chartBaseY + 15))
            valueText.fill = Color.gray
            newNodes.append(valueText)
        }
        
        let xAxis = Line(x1: 0, y1: chartBaseY, x2: lineWidth, y2: chartBaseY).stroke(fill: Color.white.with(a: 0.25))
        newNodes.append(xAxis)
        
        return newNodes
    }
    
    private static func createBars() -> Group {
        
        let fill = LinearGradient(degree: 90, from: Color(val: 0xff4704), to: Color(val: 0xff4704).with(a: 0.33))
        let items = adjustedData.map { _ in Group() }
        
        // each bar animations
        animations = items.enumerated().map { (i:Int, item:Group) in // i : index
            item.contentsVar.animation(delay: Double(i)*0.2) { t in // animation : left to right
                let height = adjustedData[i]*t
                let rect = Rect(x: Double(i)*50+20, y: 200-height, w: 20, h: height).round(rx: 7, ry: 7)
                
                return [rect.fill(with: fill)]
            }
        }
        
        return items.group()
    }
    
    // MARK : Animation Trigger
    static func playAnimations(){
        // reload aqi data
        AqiChartView.aqiBars = createData()
//        print(AqiChartView.aqiBars)
        
        animations.combine().play()
    }
        
    // MARK : set Bar Data
    static func createData() -> [AqiBar] {
        
        let aqi1 = AqiBar(time: "5시", aqiIndex: 45)
        let aqi2 = AqiBar(time: "6시", aqiIndex: 30)
        let aqi3 = AqiBar(time: "7시", aqiIndex: 20)
        let aqi4 = AqiBar(time: "8시", aqiIndex: 10)
        let aqi5 = AqiBar(time: "9시", aqiIndex: 30)
        let aqi6 = AqiBar(time: "10시", aqiIndex: 50)
        let aqi7 = AqiBar(time: "11시", aqiIndex: 40)
        let aqi8 = AqiBar(time: "12시", aqiIndex: 70)
        
        return [aqi1, aqi2, aqi3, aqi4, aqi5, aqi6, aqi7, aqi8]
    }

}

struct AqiBar {
    var time: String
    var aqiIndex: Double
}
