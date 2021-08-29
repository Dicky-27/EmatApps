//
//  MonthsTableViewCell.swift
//  EmatApps
//
//  Created by Dian Dinihari on 28/07/21.
//

import UIKit

class MonthsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableImage: UIImageView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var rupiahLabel: UILabel!
    @IBOutlet weak var kwhLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        tableImage.isAccessibilityElement   = false
        monthLabel.isAccessibilityElement   = false
        kwhLabel.isAccessibilityElement     = false
        rupiahLabel.isAccessibilityElement  = false

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
