//
//  MonthlyBudgetCell.swift
//  EmatApps
//
//  Created by Dian Dinihari on 30/07/21.
//

import UIKit
import CoreData

class MonthlyBudgetCell: UITableViewCell, UITextFieldDelegate {
    
    
    @IBOutlet weak var budgetTf: UITextField!
    @IBOutlet weak var descLbl: UILabel!
    
    weak var tableViewDelegate: UITableViewDelegate?
    
    var currentString = ""
    var user = [User]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let formatter = NumberFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        budgetTf.delegate = self
        budgetTf.borderStyle = .none
        
        loadData()
        setupAccessibility()
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
        PowerViewController.budgetCal = numberFromField
        user[0].setValue(Float(numberFromField), forKey: "budget")
        
    }
    
    func loadData() {
  
          let request : NSFetchRequest<User> = User.fetchRequest()
  
          do {
              user = try context.fetch(request)
          } catch {
              print("Error loading categories \(error)")
          }

    }
    
    func setupAccessibility() {
//        var elemets = [UIAccessibilityElement]()
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.spellOut
        formatter.locale = Locale(identifier: "en_ID")
        formatter.maximumFractionDigits = 0
//
//
//        let kwhElemetn = UIAccessibilityElement(accessibilityContainer: self)
//        //kwhElemetn.accessibilityLabel = "Current spending, \(formatter.string(from: NSNumber(value: duit)) ?? "0")Rupiah"
//        kwhElemetn.accessibilityFrameInContainerSpace = self.frame
//        elemets.append(kwhElemetn)
//
//        self.accessibilityElements = elemets
        
        self.isAccessibilityElement = true
        self.accessibilityLabel = "\(descLbl.text ?? "") ,  \(formatter.string(from: UserData.user[0].budget as NSNumber) ?? "0")rupiah , textfield"
        
    }
    
}
