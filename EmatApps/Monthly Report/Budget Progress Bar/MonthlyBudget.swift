//
//  MonthlyBudget.swift
//  EmatApps
//
//  Created by Dian Dinihari on 28/07/21.
//

import UIKit

class MonthlyBudget: UIView {

    @IBInspectable var color: UIColor? = .gray {
        didSet {setNeedsDisplay()}
    }
    
    var progress = CGFloat(TargetBill.inputedBill ?? 0.0) {
        didSet {setNeedsDisplay()}
    }
    
    private let progressLayer = CALayer()
    private let backgroundMask = CAShapeLayer()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupLayers()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupLayers()
        }

        private func setupLayers() {
            layer.addSublayer(progressLayer)
        }
    
    override func draw(_ rect: CGRect) {

        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 25).cgPath
        layer.mask = backgroundMask
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        progressLayer.frame = progressRect
        
        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = color?.cgColor
    }
}
