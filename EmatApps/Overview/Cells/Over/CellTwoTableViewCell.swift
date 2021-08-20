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
    
    func setup() {
        
        var kwhTot:Float = 0
        var power:Float = 0
        
        if EnergiesLoad.energyModel.isEmpty == false {
            for i in 0..<EnergiesLoad.energyModel.count{

                power = EnergiesLoad.energyModel[i].power ?? 0
                kwhTot += power/1000
            }
            
            let duit = Float(Float(kwhTot) * 1440.70)
        
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.currency
            formatter.locale = Locale(identifier: "id_ID")
            formatter.maximumFractionDigits = 0
            
            var numberFromField:Float = 0
            var budget:Float = 0
            
            if UserData.user.isEmpty == false {
                
                numberFromField = UserData.user[0].budget
                budget = UserData.user[0].budget
                
                rightLbl.text = formatter.string(from: numberFromField as NSNumber)
                progressBudget.progress = Float(duit / budget)
                
            }
        }

        
    }
    
    
}
