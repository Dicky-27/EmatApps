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
    @IBOutlet weak var estSpen: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        
        setupAccessbility()
    }
    
    func setupAccessbility() {
        var elemets = [UIAccessibilityElement]()
        
        let kwhElemetn = UIAccessibilityElement(accessibilityContainer: self)
        kwhElemetn.accessibilityLabel = "Estimated calculation for \(estDate.text ?? "0"), Total power usage , \(estKwh.text ?? "0") , Predicted Bill , \(estSpen.text ?? "0")"
        kwhElemetn.accessibilityFrameInContainerSpace = self.frame
        elemets.append(kwhElemetn)
        
        self.accessibilityElements = elemets
    }
    
    
}



