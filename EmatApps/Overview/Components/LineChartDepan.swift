//
//  LineChartDepan.swift
//  EmatApps
//
//  Created by Dicky Buwono on 26/07/21.
//

import UIKit

@IBDesignable
class LineChartDepan: UIView {
    private enum Constants {
        static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
        static let margin: CGFloat = 20.0
        static let topBorder: CGFloat = 60
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 0.3
        static let circleDiameter: CGFloat = 5.0
    }
    
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    
    var graphPoints: [Int] = [4, 2, 6, 4, 5, 8, 8, 5, 2, 1, 4, 2, 6, 4, 5, 8, 8, 5, 2, 1, 4, 2, 6, 4, 5, 8, 8, 5, 2, 1]
    var graphPoints2: [Int] = [2, 4, 6, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        //draw circle
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: UIRectCorner.allCorners,
            cornerRadii: Constants.cornerRadiusSize
        )
        
        
        let path2 = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: UIRectCorner.allCorners,
            cornerRadii: Constants.cornerRadiusSize
        )
        
        path.addClip()
        path2.addClip()
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let colors = [startColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        
        //gradient
        guard let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: colors as CFArray,
            locations: colorLocations
        ) else {
            return
        }
        
        //start and end point gradient
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x: 0, y: self.bounds.height)
        context.drawLinearGradient(
            gradient,
            start: startPoint,
            end: endPoint,
            options: []
        )
        
        var startPointA = CGPoint.zero
        var endPointB = CGPoint(x: 0, y: self.bounds.height)
        context.drawLinearGradient(
            gradient,
            start: startPointA,
            end: endPointB,
            options: []
        )
        
        // x point
        
        let margin = Constants.margin
        let columnXPoint = { (column: Int) -> CGFloat in
            let spacing = (width - margin * 2 - 4) / CGFloat((self.graphPoints.count - 1))
            return CGFloat(column) * spacing + margin + 2
        }
        
        
        
        let columnXPoint2 = { (column: Int) -> CGFloat in
            let spacing = (width - margin * 2 - 4) / CGFloat((self.graphPoints2.count - 1))
            return CGFloat(column) * spacing + margin + 2
        }
        
        
        let topBorder: CGFloat = Constants.topBorder
        let bottomBorder: CGFloat = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        
        
        guard let maxValue = graphPoints.max() else {
            return
        }
        
        guard let maxValue2 = graphPoints2.max() else {
            return
        }
        
        
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - yPoint
        }
        
        // y point
        
        let columnYPoint2 = { (graphPoint2: Int) -> CGFloat in
            let yPoint2 = CGFloat(graphPoint2) / CGFloat(maxValue2) * graphHeight
            
            return graphHeight + topBorder - yPoint2
        }
        
        
        let graphPath = UIBezierPath()
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            
            if graphPoints[i] == 0 {
                break
            }else {
                graphPath.addLine(to: nextPoint)
                graphPath.addQuadCurve(to: nextPoint, controlPoint: CGPoint(x: 10, y: 10))
                
                UIColor.red.setStroke()
                graphPath.stroke()
                
            }
        }
        
        let graphPath2 = UIBezierPath()
        graphPath2.move(to: CGPoint(x: columnXPoint2(0), y: columnYPoint2(graphPoints2[0])))
        
        for i in 1..<graphPoints2.count {
            
            let nextPoint2 = CGPoint(x: columnXPoint2(i), y: columnYPoint2(graphPoints2[i]))
            if graphPoints2[i] == 0 {
                break
                
            }else {
                graphPath2.addLine(to: nextPoint2)
                
                UIColor.blue.setStroke()
                graphPath.stroke()
                
            }
            
        }
        
        context.saveGState()
        
        // grid
        guard let clippingPath = graphPath.copy() as? UIBezierPath else {
            return
        }
        
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        
        clippingPath.close()
        
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue)
        startPoint = CGPoint(x: margin, y: highestYPoint)
        endPoint = CGPoint(x: margin, y: self.bounds.height)
        
        context.drawLinearGradient(
            gradient,
            start: startPoint,
            end: endPoint,
            options: CGGradientDrawingOptions(rawValue: 0)
        )
        
        let highestYPoint2 = columnYPoint2(maxValue2)
        startPointA = CGPoint(x: margin, y: highestYPoint2)
        endPointB = CGPoint(x: margin, y: self.bounds.height)
        
        context.drawLinearGradient(
            gradient,
            start: startPointA,
            end: endPointB,
            options: CGGradientDrawingOptions(rawValue: 0)
        )
        
        context.restoreGState()
        
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        graphPath2.lineWidth = 2.0
        graphPath2.stroke()
        
        
        for i in 0..<graphPoints2.count {
            
            if graphPoints2[i] == 0 {
                var point2 = CGPoint(x: columnXPoint2(i-1), y: columnYPoint2(graphPoints2[i-1]))
                point2.x -= Constants.circleDiameter / 2
                point2.y -= Constants.circleDiameter / 2
                
                let circle = UIBezierPath(
                    ovalIn: CGRect(
                        origin: point2,
                        size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)
                    )
                )
                circle.fill()
                
                break
            }
        }
        
        let linePath = UIBezierPath()
        
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: graphHeight / 2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight / 2 + topBorder))
        
        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
         
    }
}

