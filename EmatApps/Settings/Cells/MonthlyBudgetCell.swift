//
//  MonthlyBudgetCell.swift
//  EmatApps
//
//  Created by Dian Dinihari on 30/07/21.
//

import UIKit

class MonthlyBudgetCell: UITableViewCell, UITextFieldDelegate {
    
    
    @IBOutlet weak var budgetTf: UITextField!
    
    weak var tableViewDelegate: UITableViewDelegate?
    
    var currentString = ""
   
    
    let formatter = NumberFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      
        
        budgetTf.delegate = self
        budgetTf.borderStyle = .none
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            currentString += string
            formatCurrency(string: currentString)
                
        default:
            let array = Array(string)
            var currentStringArray = Array(currentString)
            if array.count == 0 && currentStringArray.count != 0 {
                currentStringArray.removeLast()
                currentString = ""
                for character in currentStringArray {
                    currentString += String(character)
                }
                formatCurrency(string: currentString)
            }
        }
        return false
        
    }
    
    func formatCurrency(string: String) {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale(identifier: "id_ID")
        let numberFromField = (NSString(string: currentString).integerValue)
        budgetTf.text = formatter.string(from: numberFromField as NSNumber)

        PowerViewController.budget = formatter.string(from: numberFromField as NSNumber) ?? ""
        
    }
}
