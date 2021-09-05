//
//  PillMarker.swift
//  EmatApps
//
//  Created by Dicky Buwono on 05/08/21.
//

import UIKit
import Charts

class PillMarker: MarkerImage {
    
    private (set) var color: UIColor
    private (set) var font: UIFont
   // private (set) var textColor: UIColor
    private var labelText: String = ""
    private var label = UILabel()
    private var attrs: [NSAttributedString.Key: AnyObject]!
    var radius: CGFloat = 10
    
    init(color: UIColor, font: UIFont) {
        self.color = color
        self.font = font
        //self.textColor = textColor
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
       
        attrs = [.font: font, .paragraphStyle: paragraphStyle, .baselineOffset: NSNumber(value: -4)]
        
       
        
        super.init()
    }
    
    override func draw(context: CGContext, point: CGPoint) {
        let labelWidth = labelText.size(withAttributes: attrs).width + 10
        let labelHeight = labelText.size(withAttributes: attrs).height + 4
        var rectangle = CGRect(x: point.x, y: point.y, width: labelWidth, height: labelHeight)
        
        
        
        if point.y < 60 {
            
            if point.x < 60{
                rectangle.origin.x -= rectangle.width / 2.0 - 100
                let spacing: CGFloat = 70
                rectangle.origin.y -= rectangle.height - spacing
                
            }else if point.x > 200 {
                rectangle.origin.x -= rectangle.width / 2.0 + 100
                let spacing: CGFloat = 70
                rectangle.origin.y -= rectangle.height - spacing
            }else {
                rectangle.origin.x -= rectangle.width / 2.0
                let spacing: CGFloat = 70
                rectangle.origin.y -= rectangle.height - spacing
            }
            
        }else {
            
            if point.x < 60{
                rectangle.origin.x -= rectangle.width / 2.0 - 100
                let spacing: CGFloat = 30
                rectangle.origin.y -= rectangle.height + spacing
                
            }else if point.x > 200 {
                rectangle.origin.x -= rectangle.width / 2.0 + 100
                let spacing: CGFloat = 30
                rectangle.origin.y -= rectangle.height - spacing
            }else {
                rectangle.origin.x -= rectangle.width / 2.0
                let spacing: CGFloat = 35
                rectangle.origin.y -= rectangle.height + spacing
            }
            
        }
        
        let clipPath = UIBezierPath(roundedRect: rectangle, cornerRadius: 6.0).cgPath
        context.addPath(clipPath)
        context.setFillColor(UIColor.white.cgColor)
        context.setStrokeColor(UIColor.white.cgColor)
        context.closePath()
        context.drawPath(using: .fillStroke)
        
        
        label.textAlignment = .left
       // labelText.draw(with: rectangle, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        label.text?.draw(with: rectangle, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        
        let circleRect = CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2)
        context.setFillColor(UIColor(named: "AccentColor")?.cgColor ?? color.cgColor)
        context.fillEllipse(in: circleRect)
        context.restoreGState()
    }
    
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        labelText = customString( value: entry.y, valueX: Int(entry.x))
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "Time Energy")
        attributedString.setColorForText(textForAttribute: "Time", withColor: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
        attributedString.setColorForText(textForAttribute: "Energy", withColor: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
        
        label.attributedText = attributedString
        
        
        
    }
    
    private func customString(value: Double, valueX: Int) -> String {
        return "Time \(Float(TimeInterval(value)).toKwhString())\nEnergy \(valueX)"
    }
}
