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
@IBDesignable
class GraphView: UIView {
    // Sample data
    var graphPoint = [4, 2, 6, 4, 5, 8, 3, 4, 2, 6, 4, 5]
    
    /*
     // gradient
     @IBInspectable var startColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
     @IBInspectable var endColor: UIColor = #colorLiteral(red: 0.8901960784, green: 0.968627451, blue: 1, alpha: 1)
     */
    
    override func draw(_ rect: CGRect) {
        
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
        
        /*
         // gradient
         let colors = [startColor.cgColor, endColor.cgColor]
         
         let colorSpace = CGColorSpaceCreateDeviceRGB()
         let colorLocations: [CGFloat] = [0.0, 1.0]
         
         guard let gradient = CGGradient(
         colorsSpace: colorSpace,
         colors: colors as CFArray,
         locations: colorLocations
         ) else {
         return
         }*/
        
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
        
        // setting up and show the line graph
        #colorLiteral(red: 0.3960784314, green: 0.7450980392, blue: 1, alpha: 1).setFill()
        #colorLiteral(red: 0.3960784314, green: 0.7450980392, blue: 1, alpha: 1).setStroke()
        
        // Set up the points line
        let graphPath = UIBezierPath()
        
        // Go to start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoint[0])))
        
        // Add points for each item in the graphPoints array
        // at the correct (x, y) for the point
        for i in 1..<graphPoint.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoint[i]))
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
        
        /*
         // gradient
         let highestYPoint = columnYPoint(maxValue)
         let graphStartPoint = CGPoint(x: margin, y: highestYPoint)
         let graphEndPoint = CGPoint(x: margin, y: bounds.height)
         
         context.drawLinearGradient(
         gradient,
         start: graphStartPoint,
         end: graphEndPoint,
         options: [])
         */
        
        context.restoreGState()
        
        // Draw the line on top of the clipped gradient
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        
        // Draw the circles on top of the graph stroke
        for i in 0..<graphPoint.count {
            #colorLiteral(red: 0.09847373515, green: 0.512232244, blue: 0.823799789, alpha: 1).setFill()
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoint[i]))
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
            //let linePath = UIBezierPath()
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
        /*
         // Draw horizontal graph lines on the top of everything
         let linePath = UIBezierPath()
         
         // Bottom line
         linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
         linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
         let color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
         color.setStroke()
         
         linePath.lineWidth = 1.0
         linePath.stroke()
         */
    }
}
