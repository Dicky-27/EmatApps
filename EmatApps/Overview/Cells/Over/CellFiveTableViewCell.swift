//
//  CellFiveTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

class CellFiveTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonEst: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        buttonEst.layer.cornerRadius = 5
        buttonEst.layer.borderWidth = 2
        buttonEst.layer.borderColor = UIColor(named: "Primary")?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
