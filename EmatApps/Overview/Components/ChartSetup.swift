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

        let marker = PillMarker(color: .white, font: UIFont.boldSystemFont(ofSize: 14), textColor: .black)
        chartView.marker = marker

        return chartView
    }()
    
    static func drawing(view: UIView) {
        
        setData()
        view.addSubview(lineChartView)
        lineChartView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        
    }
    
    static func setData() {
        
        let dataEntries1 = [ChartDataEntry]()
        var dataEntries2 = [ChartDataEntry]()
        var power: Float = 0
        let formatter = DateFormatter()
        
        if EnergiesLoad.daily_energy.isEmpty == false {

            let lastIndex = EnergiesLoad.daily_energy.count - 1
            
            for i in 0..<EnergiesLoad.daily_energy.count {
                
               
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZ"
                formatter.timeZone =  NSTimeZone(forSecondsFromGMT: 25200) as TimeZone?
                let isoDate = EnergiesLoad.daily_energy[lastIndex - i].created_at ?? ""
                let datenya = formatter.date(from: isoDate)
                let date = Date()
                let calendar = Calendar.current
                
                formatter.dateFormat = "yyyy-MM-"
                formatter.timeZone = .current

                let itu = formatter.string(from: date)
                
                
                let results = EnergiesLoad.daily_energy.filter { ($0.created_at ?? "").contains(itu) }
                let unwrap = Date()
                
                print(itu)
            

                let day = calendar.component(.day, from: datenya ?? unwrap)
                
                for j in 0..<results.count {
                    
               
                    power = results[j].energy ?? 0
                    //print(power)
                }
                
                let entry2 = ChartDataEntry.init(x: Double(day), y: Double(power))
                dataEntries2.append(entry2)
                print(dataEntries2)
                power  = 0
                
            }
            
            
            
     
        
        let set1 = LineChartDataSet(entries: dataEntries1)
        let set2 = LineChartDataSet(entries: dataEntries2)

        
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 5
        set1.setColor(UIColor(named: "Primary") ?? .black)
        set1.highlightColor = UIColor(named: "AbuA") ?? .black
        set1.drawHorizontalHighlightIndicatorEnabled = false
        
        set2.mode = .horizontalBezier
        set2.setColor(UIColor(named: "AccentColor") ?? .black)
        set2.drawCirclesEnabled = false
        set2.drawHorizontalHighlightIndicatorEnabled = false
        set2.highlightColor = UIColor(named: "AbuA") ?? .black
        set2.lineWidth = 5
        

//       let chartDataSet1 = LineChartDataSet(entries: dataEntries1, label: "temperature")
        let set3:[ChartDataSet] = [set1, set2]
            
        let data = LineChartData(dataSets: set3)
        data.setDrawValues(true)
        lineChartView.data = data
        
        }
    
    }
}
