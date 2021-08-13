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
    
        var lineChartView: LineChartView = {
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
    
    override func draw(_ rect: CGRect) {
        setData()
        self.addSubview(lineChartView)
        lineChartView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        
    }
    
    func setData() {
        
//        print("hello")
//        var kwhTot:Float = 0
//        var power:Float = 0
//        var cekIndex = 1
        
        var dataEntries1 = [ChartDataEntry]()
        var dataEntries2 = [ChartDataEntry]()
        
        if EnergiesLoad.energyModel.isEmpty == false {
        for i in 0..<EnergiesLoad.energyModel.count{
            guard let y = EnergiesLoad.energyModel[i].power else { return }


            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))


            dataEntries1.append(entry)

            }
            
        for i in 0..<EnergiesLoad.energyModel.count{
            guard let y = EnergiesLoad.energyModel[i].power else { return }


            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))


            dataEntries2.append(entry)

            }
  /*
        for i in stride(from: 0, through: EnergiesLoad.energyModel.count, by: 1) {
                
                cekIndex += i

                if (cekIndex >= 0 && EnergiesLoad.energyModel.count > cekIndex) {

                    let isoDate = EnergiesLoad.energyModel[i].created_at ?? ""
                    let nextDay = EnergiesLoad.energyModel[i].created_at ?? ""

                    let dateFormatter = DateFormatter()

                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZ"
                    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                    let date = dateFormatter.date(from: isoDate)
                    let dateNext = dateFormatter.date(from: nextDay)

                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss xxxx'"
                    dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 25200) as TimeZone?


                    let calendar = Calendar.current
                    let unwrap = Date()

                    let day = calendar.component(.day, from: date ?? unwrap)
                    let datAfter = calendar.component(.day, from: dateNext ?? unwrap)


                    if day == datAfter {

                        power = EnergiesLoad.energyModel[i].power ?? 0
                        kwhTot += power/1000

                    }else {

                         let entry2 = ChartDataEntry.init(x: Double(i), y: Double(kwhTot))
                         dataEntries2.append(entry2)
                         
                        
                    }
                }

            }
           
        }
        
     */
        
        let set1 = LineChartDataSet(entries: dataEntries1)
        let set2 = LineChartDataSet(entries: dataEntries2)

        
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 5
        set1.setColor(UIColor(named: "Primary") ?? .black)
        set1.highlightColor = UIColor(named: "AbuA") ?? .black
        set1.drawHorizontalHighlightIndicatorEnabled = false
        
        set2.mode = .cubicBezier
        set2.setColor(UIColor(named: "Accent") ?? .black)
        set2.drawCirclesEnabled = true
        set2.drawHorizontalHighlightIndicatorEnabled = false
        set2.highlightColor = UIColor(named: "AbuA") ?? .black
        set2.lineWidth = 5
        

//        let chartDataSet1 = LineChartDataSet(entries: dataEntries1, label: "temperature")
        let set3:[ChartDataSet] = [set1, set2]
            
        let data = LineChartData(dataSets: set3)
        data.setDrawValues(true)
        lineChartView.data = data
        
    }
    
}

}
