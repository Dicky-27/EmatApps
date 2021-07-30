//
//  MonthlyBudgetCell.swift
//  EmatApps
//
//  Created by Dian Dinihari on 30/07/21.
//

import UIKit

class MonthlyBudgetCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var monthlyBudgetLabel: UILabel!
    @IBOutlet weak var rupiahLabel: UILabel!
    @IBOutlet weak var budgetField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
