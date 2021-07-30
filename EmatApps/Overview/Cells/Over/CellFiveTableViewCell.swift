//
//  CellFiveTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

class CellFiveTableViewCell: UITableViewCell {

    @IBOutlet weak var usageBg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        usageBg.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
