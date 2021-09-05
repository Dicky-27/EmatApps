//
//  MarkerChart.swift
//  EmatApps
//
//  Created by Dicky Buwono on 24/08/21.
//

import Foundation
import UIKit
import Charts



class MarkerChart: MarkerView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var markerBoard: UIView!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbEnergy: UILabel!
    var radius: CGFloat = 10
    let circle = UIView()
    let circle2 = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        initUI()
    
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initUI()
   
    }
    
    
    private func initUI() {
    
        
        Bundle.main.loadNibNamed("Marker", owner: self, options: nil)
                addSubview(contentView)
        markerBoard.layer.cornerRadius = 5
        self.markerBoard.frame = CGRect(x: 20, y: 20, width: 120, height: 50)
            
        circle.frame = CGRect(x: -10, y: -10, width: 23, height: 23)
        circle.backgroundColor = UIColor.white
        circle.layer.cornerRadius =  min(circle.frame.size.height, circle.frame.size.width) / 2.0
        circle.layer.borderWidth = 5
        circle.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        circle.clipsToBounds = true
        
        
        markerBoard.addSubview(circle)
    }
    
    override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
        
        var offset = CGPoint()
        let chart = self.chartView
        let width = self.markerBoard.frame.width
        let height = self.markerBoard.frame.height
        
        let origin = point
        
        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x
            circle.center = CGPoint(x: -(offset.x+20), y: -(offset.y+20))
        }
        else if chart != nil && origin.x + width + offset.x > chart!.viewPortHandler.contentRect.maxX
        {
            offset.x =  -(width + 40)
            circle.center = CGPoint(x: -(offset.x+20), y: -(offset.y+20))
        }

        if origin.y + offset.y < 0
        {
            offset.y = height
            circle.center = CGPoint(x: -(offset.x+20), y: -(offset.y+20))
        }
        
        else if chart != nil && origin.y + height + offset.y > chart!.viewPortHandler.contentRect.maxY
        {
            offset.y =  -(height + 40)

            circle.center = CGPoint(x: -(offset.x+20), y: -(offset.y+20))
        }
        
        circle.center = CGPoint(x: -(offset.x+20), y: -(offset.y+20))
        return offset
        
        
    }
    

 
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        lbTime.text = "\(Int(entry.x))"
        lbEnergy.text = "\(Float(entry.y).toKwhString())"
        
        
    }
    
    
    
}
