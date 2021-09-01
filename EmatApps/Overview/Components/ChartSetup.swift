//
//  ChartSetup.swift
//  EmatApps
//
//  Created by Dicky Buwono on 13/08/21.
//

import Foundation
import Charts
import UIKit

class ChartSetup: UIView{

    
       static var lineChartView: LineChartView = {
        let chartView = LineChartView()
        let yAxis = chartView.leftAxis

        chartView.noDataTextColor = UIColor(named: "Black") ?? .black
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.legend.enabled = false


        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(3, force: false)
        yAxis.axisMinLabels = 0
        yAxis.axisMinimum = 0
        yAxis.labelTextColor = .black
        yAxis.axisLineColor = .black
        yAxis.labelPosition = .outsideChart
        yAxis.labelAlignment = .center
        yAxis.gridColor = .black


        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = UIColor(named: "Black") ?? .blue
        chartView.xAxis.axisLineColor = UIColor.systemGray
        chartView.xAxis.gridColor = UIColor(named: "Grey") ?? .black

        chartView.xAxis.axisMinLabels = 1
        chartView.xAxis.axisMaxLabels = 30
        chartView.xAxis.axisMinimum = 0
        chartView.xAxis.axisMaximum = 30

        let customMarkerView = MarkerChart()
        customMarkerView.chartView = chartView
        chartView.marker = customMarkerView
        
        return chartView
    }()
    
    static func drawing(view: UIView) {
        
        setData()
        view.addSubview(lineChartView)
        lineChartView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        

        
    }
    
    static func setData() {
        
        var dataEntries1 = [ChartDataEntry]()
        var dataEntries2 = [ChartDataEntry]()
        var power: Float = 0
        var powerBefore: Float = 0
        let formatter = DateFormatter()
        var result: [Daily_Energies] = []
        var resultBefore: [Daily_Energies] = []
        let unwrap = Date()
        let calendar = Calendar.current
        
        if EnergiesLoad.daily_energy.isEmpty == false {

            let lastIndex = EnergiesLoad.daily_energy.count - 1
            let date = Date()

            formatter.dateFormat = "yyyy-MM-"
            formatter.timeZone = .current

            let itu = formatter.string(from: date)
            let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? unwrap
            let prev = formatter.string(from: previousMonth)
            
            result = EnergiesLoad.daily_energy.filter { ($0.created_at ?? "").contains(itu) }
            resultBefore = EnergiesLoad.daily_energy.filter { ($0.created_at ?? "").contains(prev) }
            
           
        
            if result.isEmpty == false {
                for i in 0..<result.count {
                    let tryv = result.indices.contains((lastIndex+1) - i)
                    if tryv == true  {
                        power = result[lastIndex - i].energy ?? 0
                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZ"
                        formatter.timeZone =  NSTimeZone(forSecondsFromGMT: 25200) as TimeZone?
                        let isoDate = EnergiesLoad.daily_energy[lastIndex - i].created_at ?? ""
                        let datenya = formatter.date(from: isoDate)
                        let day = calendar.component(.day, from: datenya ?? unwrap)
                        let entry2 = ChartDataEntry.init(x: Double(day), y: Double(power))
                        dataEntries2.append(entry2)

                        power  = 0
                    }

                }

            }else {
                dataEntries2 = []
            }
           
            
            
            if resultBefore.isEmpty == false {
                for i in 0..<resultBefore.count {
                    let tryv = resultBefore.indices.contains((lastIndex+1) - i)
                    if tryv == true  {
                        powerBefore = resultBefore[lastIndex - i].energy ?? 0
                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZ"
                        formatter.timeZone =  NSTimeZone(forSecondsFromGMT: 25200) as TimeZone?
                        let isoDate = EnergiesLoad.daily_energy[lastIndex - i].created_at ?? ""
                        let datenya = formatter.date(from: isoDate)
                        let day = calendar.component(.day, from: datenya ?? unwrap)
                        let entry = ChartDataEntry.init(x: Double(day), y: Double(powerBefore))
                    
                        dataEntries1.append(entry)
                    
                        powerBefore  = 0
                    }
                    
                }
                
            }else {
                dataEntries1 = []
            }

     
        
        let set1 = LineChartDataSet(entries: dataEntries1)
        let set2 = LineChartDataSet(entries: dataEntries2)

        if let lastPosition = dataEntries2.last {
            let point:CGPoint = lineChartView.getPosition(entry: lastPosition, axis: .right)
            
            
            let circle = UIView()
            circle.frame = CGRect(x: point.x - 10, y: point.y - 10, width: 20, height: 20)
            circle.backgroundColor = UIColor.red
            circle.layer.cornerRadius =  min(circle.frame.size.height, circle.frame.size.width) / 2.0
            circle.clipsToBounds = true
            
            
        }
        
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 5
        set1.setColor(UIColor(named: "Primary") ?? .black)
        set1.highlightColor = UIColor(named: "Black") ?? .black
        set1.drawHorizontalHighlightIndicatorEnabled = false
        
        set2.mode = .horizontalBezier
        set2.setColor(UIColor(named: "AccentColor") ?? .black)
        set2.drawCirclesEnabled = false
        set2.drawHorizontalHighlightIndicatorEnabled = false
        set2.highlightColor = UIColor(named: "Black") ?? .black
        set2.lineWidth = 5
        
        let set3:[ChartDataSet] = [set1, set2]
            
        let data = LineChartData(dataSets: set3)
        data.setDrawValues(false)
        lineChartView.data = data
        
        }
    
    }
}
