//
//  CellFourTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

class CellFourTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewRight: UIView!
    
    @IBOutlet weak var kwhStats: UILabel!
    @IBOutlet weak var powerStats: UILabel!
    
    
    let formatter2 = MeasurementFormatter()
    var timer = Timer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewLeft.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        viewRight.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        viewLeft.layer.cornerRadius = 8
        viewRight.layer.cornerRadius = 8
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
