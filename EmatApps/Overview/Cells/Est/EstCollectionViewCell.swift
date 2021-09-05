//
//  EstCollectionViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 30/07/21.
//

import UIKit

class EstCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var estDate: UILabel!
    @IBOutlet weak var estKwh: UILabel!
    @IBOutlet weak var separatorLine: UIView!
    @IBOutlet weak var estSpen: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let uang: Float = 138.8
        let kwh: Float = 200000
        setupAccessbility(uang: uang, kwh: kwh)
    }
    
    func setupAccessbility(uang: Float, kwh: Float) {
        var elemets = [UIAccessibilityElement]()
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.spellOut
        formatter.locale = Locale(identifier: "en_ID")
        formatter.maximumFractionDigits = 0
        
        let kwhElemetn = UIAccessibilityElement(accessibilityContainer: self)
        kwhElemetn.accessibilityLabel = "Estimated calculation for \(estDate.text ?? ""), Total power usage , \((kwh * 100).rounded()/100 as NSNumber) kilowatt hour , Predicted Bill , \(formatter.string(from: uang as NSNumber) ?? "0")rupiah"
        kwhElemetn.accessibilityFrameInContainerSpace = self.frame
        elemets.append(kwhElemetn)
        
        self.accessibilityElements = elemets
    }
    
    
    func setupAppearance() {
        
        
    }
    
}



