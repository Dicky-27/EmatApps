//
//  CellOneTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

class CellOneTableViewCell: UITableViewCell {
    @IBOutlet weak var lastLeg: UIView!
    @IBOutlet weak var thisLeg: UIView!
    
    @IBOutlet weak var chartOver: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thisLeg.layer.cornerRadius = thisLeg.frame.size.width/2
        lastLeg.layer.cornerRadius = thisLeg.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
