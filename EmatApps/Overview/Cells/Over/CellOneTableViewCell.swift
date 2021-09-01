//
//  CellOneTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

class CellOneTableViewCell: UITableViewCell {
    @IBOutlet weak var lastLeg: UIView!
    @IBOutlet weak var thisLeg: UIView!
    
    @IBOutlet weak var chartOver: UIView!
    @IBOutlet weak var dateNow: UILabel!
    @IBOutlet weak var moneySave: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thisLeg.layer.cornerRadius = thisLeg.frame.size.width/2
        lastLeg.layer.cornerRadius = thisLeg.frame.size.width/2
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupAccessbility() {
        var elemets = [UIAccessibilityElement]()
        
        let kwhElemetn = UIAccessibilityElement(accessibilityContainer: self)
        
        kwhElemetn.accessibilityLabel = "\(dateNow.text ?? "0"), you save \(moneySave.text ?? "0") from last month"
        kwhElemetn.accessibilityFrameInContainerSpace = dateNow.frame.union(moneySave.frame).union(chartOver.frame)
        elemets.append(kwhElemetn)
        
        self.accessibilityElements = elemets
    }
    
    
    func setData() {
        
        let calendar = Calendar.current
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let day = calendar.component(.day, from: date)
        let month = dateFormatter.string(from: date)
        
        dateNow.text = "\(day) \(month)"
        
        
        var power: Float = 0
        var powerBefore: Float = 0
        var kwhTot:Float = 0
        var kwhTotBefore:Float = 0
        let formatter = DateFormatter()
        var result: [Daily_Energies] = []
        var resultBefore: [Daily_Energies] = []
        let unwrap = Date()
        
        
        
        if EnergiesLoad.daily_energy.isEmpty == false {
            
            let state = UserData.user[0].power
            let lastIndex = EnergiesLoad.daily_energy.count - 1
            let date = Date()

            formatter.dateFormat = "yyyy-MM-"
            formatter.timeZone = .current

            let itu = formatter.string(from: date)
            let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? unwrap
            let prev = formatter.string(from: previousMonth)
            
            result = EnergiesLoad.daily_energy.filter { ($0.created_at ?? "").contains(itu) }
            resultBefore = EnergiesLoad.daily_energy.filter { ($0.created_at ?? "").contains(prev) }
            
           
        
            if result.isEmpty == false {
                for i in 0..<result.count {
                    let tryv = result.indices.contains((lastIndex+1) - i)
                    if tryv == true  {
                        power = result[lastIndex - i].energy ?? 0
                        kwhTot += power
                        power  = 0
                    }

                }

            }else {
               kwhTot = 0
            }
           
            
        
            if resultBefore.isEmpty == false {
                for i in 0..<resultBefore.count {
                    let tryv = resultBefore.indices.contains((lastIndex+1) - i)
                    if tryv == true  {
                        powerBefore = resultBefore[lastIndex - i].energy ?? 0
                        kwhTotBefore += powerBefore
                        powerBefore  = 0
                    }
                    
                }
                
            }else {
               kwhTotBefore = 0
            }

     
            var harga: Float = 0
            if state >= 399.0 && state <= 1000.0 {
                harga = 1352
            }else {
                harga = 1440.70
            }
            
            let duit = kwhTot * harga
            let duitBefore = kwhTotBefore * harga
            let saving = "\(duitBefore - duit)"
            
            let formatterNumber = NumberFormatter()
            formatterNumber.numberStyle = NumberFormatter.Style.currency
            formatterNumber.locale = Locale(identifier: "id_ID")
            let numberFromField = (NSString(string: saving).integerValue)
            moneySave.text = formatterNumber.string(from: numberFromField as NSNumber)
            
            setupAccessbility()
        }
    
    }
}
