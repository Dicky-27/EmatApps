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
    
    weak var tableViewDelegate: UITableViewDelegate?
    
    var currentString = ""
    let inputText = TargetBill.init()
    
    let formatter = NumberFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        budgetField.delegate = self
        
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

        formatter.numberStyle           = .decimal
        formatter.groupingSeparator     = "."
        formatter.maximumFractionDigits = 0
        
        let numberFromField = (NSString(string: currentString).integerValue)
        self.budgetField.text = formatter.string(from: NSNumber(value: numberFromField))
        
        //print(self.budgetField.text ?? "" )
    }
    
    // make the keyboard dissapear after typing is "done"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // get the rupiah from textfield
        if let rupiahAmount = textField.text {
            
            TargetBill.inputedBill = Float(rupiahAmount)
        
            //print("rupiah amount: \(rupiahAmount)")
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        budgetField = textField
        let inputDone = budgetField
        inputDone?.text = formatter.string(from: NSNumber(value: TargetBill.inputedBill ?? 0.0))
    }
}
