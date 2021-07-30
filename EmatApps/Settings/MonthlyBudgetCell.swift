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
    
    var currentString = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        budgetField.delegate = self
        //budgetField.keyboardType = .numbersAndPunctuation
        budgetField.autocorrectionType = .no
        budgetField.returnKeyType = .done
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textFieldHasText = (textField.text), !textFieldHasText.isEmpty else {
                //early escape if nil
                return true
            }
        
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            currentString += string
            formatCurrency(string: currentString)
        default:
            print("\nstring = \(string) | string_count = \(string.count)")
            if string.count == 0 && currentString.count != 0 {
                currentString = String(currentString.dropLast())
                formatCurrency(string: currentString)
            }
        }
        return false
    }
    
    
    func formatCurrency(string: String) {
        print("format \(string)")
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = .current
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 0
        let numberFromField = (NSString(string: currentString).integerValue)
        //replace billTextField with your text field name
        self.budgetField.text = formatter.string(from: NSNumber(value: numberFromField))
        print(self.budgetField.text ?? "" )
    }
    
    // make the keyboard dissapear after typing is "done"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // get the rupiah from textfield
        if let rupiahAmount = textField.text {
            
            print("\(rupiahAmount)")
        }
        return true
    }
}
