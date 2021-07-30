//
//  GraphViewChart.swift
//  EmatApps
//
//  Created by Dicky Buwono on 27/07/21.
//

import Foundation
import UIKit

class GraphViewChart: UIView {
    
    

    var data: [CGFloat] = [0, 1, 2, 3, 4, 5, 12, 3, 5, 5, 5] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var data2: [CGFloat] = [0, 2, 6, 12, 4, 5, 7, 5, 5, 5, 5] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    
    
    func coordYFor(index: Int) -> CGFloat {
        return bounds.height - bounds.height * data[index] / (data.max() ?? 0) + 30
    }
    
    func coordYFor2(index: Int) -> CGFloat {
        return bounds.height - bounds.height * data2[index] / (data2.max() ?? 0) + 30
    }
    
    
//    let columnYPoint = { (graphPoint: Int) -> CGFloat in
//      let yPoint = CGFloat(graphPoint) / CGFloat(m) * graphHeight
//      return graphHeight + 60 - yPoint
//    }

    

    override func draw(_ rect: CGRect) {

        
        
        let width = rect.width
        let height = rect.height
        
        let linePath = UIBezierPath()
       // let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
        let margin: CGFloat = 20.0
//        let topBorder: CGFloat = 60
//        let bottomBorder: CGFloat = 50
        let colorAlpha: CGFloat = 0.3
      //  let circleDiameter: CGFloat = 5.0
        
        guard let maxValue = data2.max() else {
          return
        }
      
        
       // let graphHeight = height - topBorder - bottomBorder

        let columnXPoint = { (column: Int) -> CGFloat in
          let spacing = (width - margin * 2 - 4) / CGFloat((self.data2.count - 1))
          return CGFloat(column) * spacing + margin + 2
        }
        
        
        for i in 0..<data2.count {
            
            
            linePath.move(to: CGPoint(x: columnXPoint(i), y: margin))
            linePath.addLine(to: CGPoint(x: columnXPoint(i), y: height))

            let color = UIColor(white: 1.0, alpha: colorAlpha)
            color.setStroke()

            linePath.lineWidth = 1.0
            linePath.stroke()
            
        }
        
        
        
        
        let path = quadCurvedPath(w: width)

        UIColor.black.setStroke()
        path.lineWidth = 4
        path.stroke()
        

        let path2 = quadCurvedPath2(w: width, h: height, m: maxValue)

        
        UIColor.red.setStroke()
        path2.lineWidth = 4
        path2.stroke()
    }

    
    
    
    
    func quadCurvedPath(w: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let step = bounds.width / CGFloat(data.count - 1)

        var p1 = CGPoint(x: 0, y: coordYFor(index: 0))
        path.move(to: p1)

       // drawPoint(point: p1, color: UIColor.red, radius: 3)
        
        let columnXPoint = { (column: Int) -> CGFloat in
          let spacing = (w - 20 * 2 - 4) / CGFloat((self.data.count - 1))
          return CGFloat(column) * spacing + 20 + 2
        }

        if (data.count == 2) {
            path.addLine(to: CGPoint(x: step, y: coordYFor(index: 1)))
            return path
        }

        var oldControlP: CGPoint?

        for i in 1..<data.count {
            let p2 = CGPoint(x: columnXPoint(i), y: coordYFor(index: i))
           // drawPoint(point: p2, color: UIColor.red, radius: 3)
            var p3: CGPoint?
            if i < data.count - 1 {
                p3 = CGPoint(x: step * CGFloat(i + 1), y: coordYFor(index: i + 1))
            }

            let newControlP = controlPointForPoints(p1: p1, p2: p2, next: p3)

            path.addCurve(to: p2, controlPoint1: oldControlP ?? p1, controlPoint2: newControlP ?? p2)

            p1 = p2
            oldControlP = antipodalFor(point: newControlP, center: p2)
        }
        return path;
    }
    
    
    ///curve kedua
    
    func quadCurvedPath2(w: CGFloat, h: CGFloat, m: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let step = bounds.width / CGFloat(data2.count - 1)

        var p1 = CGPoint(x: 0, y: coordYFor2(index: 0))
        path.move(to: p1)
        
        let columnXPoint = { (column: Int) -> CGFloat in
          let spacing = (w - 20 * 2 - 4) / CGFloat((self.data2.count - 1))
          return CGFloat(column) * spacing + 20 + 2
        }
        
        

       // drawPoint(point: p1, color: UIColor.red, radius: 3)

        if (data2.count == 2) {
            path.addLine(to: CGPoint(x: step, y: coordYFor2(index: 1)))
            return path
        }

        var oldControlP: CGPoint?

        for i in 1..<data2.count {
           // let p2 = CGPoint(x: step * CGFloat(i), y: coordYFor2(index: i))
            let p2 = CGPoint(x: columnXPoint(i), y: coordYFor2(index: i))
            let lastPoint = CGPoint (x: columnXPoint(data2.count - 1), y: coordYFor2(index: data2.count - 1))
            
            drawPoint(point: lastPoint, color: UIColor.red, radius: 7)
            var p3: CGPoint?
            if i < data2.count - 1 {
                p3 = CGPoint(x: step * CGFloat(i + 1), y: coordYFor2(index: i + 1))
            }

            let newControlP = controlPointForPoints(p1: p1, p2: p2, next: p3)

            path.addCurve(to: p2, controlPoint1: oldControlP ?? p1, controlPoint2: newControlP ?? p2)

            p1 = p2
            oldControlP = antipodalFor(point: newControlP, center: p2)
        }
        return path;
    }

    /// located on the opposite side from the center point
    func antipodalFor(point: CGPoint?, center: CGPoint?) -> CGPoint? {
        guard let p1 = point, let center = center else {
            return nil
        }
        let newX = 2 * center.x - p1.x
        let diffY = abs(p1.y - center.y)
        let newY = center.y + diffY * (p1.y < center.y ? 1 : -1)

        return CGPoint(x: newX, y: newY)
    }
    
    

    /// halfway of two points
    func midPointForPoints(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2);
    }

    /// Find controlPoint2 for addCurve
    /// - Parameters:
    ///   - p1: first point of curve
    ///   - p2: second point of curve whose control point we are looking for
    ///   - next: predicted next point which will use antipodal control point for finded
    func controlPointForPoints(p1: CGPoint, p2: CGPoint, next p3: CGPoint?) -> CGPoint? {
        guard let p3 = p3 else {
            return nil
        }

        let leftMidPoint  = midPointForPoints(p1: p1, p2: p2)
        let rightMidPoint = midPointForPoints(p1: p2, p2: p3)

        var controlPoint = midPointForPoints(p1: leftMidPoint, p2: antipodalFor(point: rightMidPoint, center: p2)!)

        if p1.y.between(a: p2.y, b: controlPoint.y) {
            controlPoint.y = p1.y
        } else if p2.y.between(a: p1.y, b: controlPoint.y) {
            controlPoint.y = p2.y
        }


        let imaginContol = antipodalFor(point: controlPoint, center: p2)!
        if p2.y.between(a: p3.y, b: imaginContol.y) {
            controlPoint.y = p2.y
        }
        if p3.y.between(a: p2.y, b: imaginContol.y) {
            let diffY = abs(p2.y - p3.y)
            controlPoint.y = p2.y + diffY * (p3.y < p2.y ? 1 : -1)
        }

        // make lines easier
        controlPoint.x += (p2.x - p1.x) * 0.1

        return controlPoint
    }

    func drawPoint(point: CGPoint, color: UIColor, radius: CGFloat) {
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2))
        color.setFill()
        ovalPath.fill()
    }
    
    

}

extension CGFloat {
    func between(a: CGFloat, b: CGFloat) -> Bool {
        return self >= Swift.min(a, b) && self <= Swift.max(a, b)
    }
}
