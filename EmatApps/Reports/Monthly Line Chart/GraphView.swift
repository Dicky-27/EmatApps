//
//  GraphView.swift
//  EmatApps
//
//  Created by Dian Dinihari on 26/07/21.
//

import UIKit

private enum Constants {
    static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
    static let margin: CGFloat = 8
    static let topBorder: CGFloat = 60
    static let bottomBorder: CGFloat = 30
    static let colorAlpha: CGFloat = 0.3
    static let circleDiameter: CGFloat = 10
}

//@IBDesignable
class GraphView: UIView {
    
    let monthData = MonthlyData.init()
    var monthContent: [MonthlyPower] = []
    var graphPoint : [Float] = []

    override func draw(_ rect: CGRect) {
        
        monthData.loadMonthly()
        monthContent = monthData.getFullData()
        graphPoint = monthData.getPowerList()
        
        let width = rect.width
        let height = rect.height
        let path = UIBezierPath(
            
            roundedRect: rect,
            byRoundingCorners: .allCorners,
            cornerRadii: Constants.cornerRadiusSize
        )
        
        path.addClip()
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        var spacingPoint : CGFloat = 0.0
        var currPoint : CGFloat = 0.0
        
        // Calculate the x point
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (column: Int) -> CGFloat in
            
            // Calculate the gap between points
            let spacing = graphWidth / CGFloat(self.graphPoint.count - 1)
            spacingPoint = spacing
            return CGFloat(column) * spacing + margin + 2
        }
        
        // Calculate the y point
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        guard let maxValue = graphPoint.max() else {
            return
        }
        
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - yPoint
        }
        
        // show the line graph
        #colorLiteral(red: 0.3960784314, green: 0.7450980392, blue: 1, alpha: 1).setFill()
        #colorLiteral(red: 0.3960784314, green: 0.7450980392, blue: 1, alpha: 1).setStroke()
        
        // Set up the points line
        let graphPath = UIBezierPath()
        
        // Go to start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(Int(graphPoint[0]))))
        
        // Add points for each item in the graphPoints array at the correct (x, y) for the point
        for i in 1..<graphPoint.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(Int(graphPoint[i])))
            graphPath.addLine(to: nextPoint)
        }
        
        // Save the state of the context
        context.saveGState()
        
        // Make a copy of the path
        guard let clippingPath = graphPath.copy() as? UIBezierPath else {
            return
        }
        
        // Add lines to the copied path to complete the clip area
        clippingPath.addLine(to: CGPoint(
                                x: columnXPoint(graphPoint.count - 1),
                                y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clippingPath.close()
        
        // Add the clipping path to the context
        clippingPath.addClip()
        context.restoreGState()
        
        // Draw the line on top of the clipped gradient
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        // Draw the circles on top of the graph stroke
        for i in 0..<graphPoint.count {
            #colorLiteral(red: 0.09847373515, green: 0.512232244, blue: 0.823799789, alpha: 1).setFill()
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(Int(graphPoint[i])))
            point.x -= Constants.circleDiameter / 2
            point.y -= Constants.circleDiameter / 2
            
            let circle = UIBezierPath(
                ovalIn: CGRect(
                    origin: point,
                    size: CGSize(
                        width: Constants.circleDiameter,
                        height: Constants.circleDiameter
                    )
                )
            )
            
            // Draw vertical graph lines
            let linePath = UIBezierPath(roundedRect: rect, cornerRadius: 10.0)
            linePath.move(to: CGPoint(x: margin + currPoint + 2, y: bottomBorder))
            linePath.addLine(to: CGPoint(x: margin + currPoint + 2, y: graphHeight + topBorder))
            
            let color = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            color.setStroke()
            linePath.lineWidth = 2.0
            
            let dashPattern: [CGFloat] = [4.0, 2.0]
            linePath.setLineDash(dashPattern, count: dashPattern.count, phase: 0)
            linePath.stroke(with: .lighten, alpha: 0.5)
            currPoint += spacingPoint
            
            circle.fill()
        }
    }
}
