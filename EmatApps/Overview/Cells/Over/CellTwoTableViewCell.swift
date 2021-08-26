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
        
        if EnergiesLoad.daily_energy.isEmpty == false {
            
            let formatter = DateFormatter()
            var result: [Daily_Energies] = []
            
            let lastIndex = EnergiesLoad.daily_energy.count - 1
            let date = Date()
            
            if date == date.startOfMonth {
                kwhTot = 0
            }
                
            formatter.dateFormat = "yyyy-MM-"
            formatter.timeZone = .current

            let itu = formatter.string(from: date)
            
            result = EnergiesLoad.daily_energy.filter { ($0.created_at ?? "").contains(itu) }
            
            for i in 0..<result.count {
                let tryv = result.indices.contains((lastIndex+1) - i)
                if tryv == true  {
                    power = (result[lastIndex - i].energy ?? 0) - (result[(lastIndex+1) - i].energy ?? 0)
                    kwhTot += power
                    
                    power  = 0
                }
                
            }
    
            
            let duit = Float(Float(kwhTot) * 1440.70)
        
            let formatterNumber = NumberFormatter()
            formatterNumber.numberStyle = NumberFormatter.Style.currency
            formatterNumber.locale = Locale(identifier: "id_ID")
            formatterNumber.maximumFractionDigits = 0
            
            var numberFromField:Float = 0
            var budget:Float = 0
            
            if UserData.user.isEmpty == false {
                
                numberFromField = UserData.user[0].budget
                budget = UserData.user[0].budget
                
                rightLbl.text = formatterNumber.string(from: numberFromField as NSNumber)
                progressBudget.progress = Float(duit / budget)
                
                setupAccessbility()
                
            }
        }

        
    }
    
    func setupAccessbility() {
        var elemets = [UIAccessibilityElement]()
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.spellOut
        formatter.locale = Locale(identifier: "id_ID")
        formatter.maximumFractionDigits = 0
        
//        let currencyName = locale.localizedString(forCurrencyCode: locale.currencyCode!)!
//        label.accessibilityLabel = NumberFormatter.localizedString(from: NSNumber(value: 1000000), number: .spellOut) + currencyName
        
        let formatter2 = NumberFormatter()
        formatter2.numberStyle = .percent
        
        let kwhElemetn = UIAccessibilityElement(accessibilityContainer: self)
        kwhElemetn.accessibilityLabel = "Your monthly budget, \(formatter.string(from: NSNumber(value: UserData.user[0].budget)) ?? "0") , Your current spending progress , \(formatter2.string(from: NSNumber(value: progressBudget.progress)) ?? "0")"
        
        kwhElemetn.accessibilityFrameInContainerSpace = leftLbl.frame.union(rightLbl.frame).union(progressBudget.frame)
        elemets.append(kwhElemetn)
        self.accessibilityElements = elemets
    }
    
    
}
