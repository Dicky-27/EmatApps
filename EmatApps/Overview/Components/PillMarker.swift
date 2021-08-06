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
    private (set) var textColor: UIColor
    private var labelText: String = ""
    private var attrs: [NSAttributedString.Key: AnyObject]!
    
    
    var radius: CGFloat = 10
    
    init(color: UIColor, font: UIFont, textColor: UIColor) {
        self.color = color
        self.font = font
        self.textColor = textColor

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        attrs = [.font: font, .paragraphStyle: paragraphStyle, .foregroundColor: textColor, .baselineOffset: NSNumber(value: -4)]
        super.init()
    }

    override func draw(context: CGContext, point: CGPoint) {
        // custom padding around text
        let labelWidth = labelText.size(withAttributes: attrs).width + 10
        
        // if you modify labelHeigh you will have to tweak baselineOffset in attrs
        let labelHeight = labelText.size(withAttributes: attrs).height + 4
        // place pill above the marker, centered along x
        
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
        
        
        // rounded rect
        let clipPath = UIBezierPath(roundedRect: rectangle, cornerRadius: 6.0).cgPath
        context.addPath(clipPath)
        context.setFillColor(UIColor.white.cgColor)
        context.setStrokeColor(UIColor.white.cgColor)
        context.closePath()
        context.drawPath(using: .fillStroke)

        // add the text
        labelText.draw(with: rectangle, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        
        let circleRect = CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2)
      
        context.setFillColor(UIColor(named: "Accent")?.cgColor ?? color.cgColor)
        context.fillEllipse(in: circleRect)
        
        context.restoreGState()
    }

    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        labelText = customString(Int(entry.y), valueX: Int(entry.x))
        
    }

    private func customString(_ value: Int, valueX: Int) -> String {
      
//        var stringValue = "Energy : \(TimeInterval(value)) Kwh \n Day : \(valueX)"
//        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
//        attributedString.setColorForText(textForAttribute: "Emat", withColor: #colorLiteral(red: 0.08218777925, green: 0.5918437839, blue: 0.8580096364, alpha: 1))
//        
//        labelText.font = UIFont(name: "Poppins", size: 14)
//        labelText.attributedText = attributedString
//       
        return "Energy : \(TimeInterval(value)) Kwh \n Day : \(valueX)"
    }
}
