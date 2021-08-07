//
//  CellTwoTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

class CellTwoTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLbl: UILabel!
    @IBOutlet weak var rightLbl: UILabel!
    @IBOutlet weak var progressBudget: MonthlyBudget!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
