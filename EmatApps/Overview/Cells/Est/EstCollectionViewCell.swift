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
        
    }
}



