//
//  CellThreeTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

class CellThreeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var currentSpen: UILabel!
    
    
    var timer = Timer()
    var count = 0
    
    
    let date3 = Date()
    let formatter = NumberFormatter()
    let dateFormatter = DateFormatter()
    let formatter2 = MeasurementFormatter()
    
    var iteration = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addGradientBackground(firstColor: UIColor(named: "Background") ?? .blue, secondColor: UIColor(named: "Wblack") ?? .white)
        viewBg.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        viewBg.layer.cornerRadius = 8
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupAccessbility(duit: Int) {
        var elemets = [UIAccessibilityElement]()
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.spellOut
        formatter.locale = Locale(identifier: "en_ID")
        formatter.maximumFractionDigits = 0
        
        
        let kwhElemetn = UIAccessibilityElement(accessibilityContainer: self)
        kwhElemetn.accessibilityLabel = "Current spending, \(formatter.string(from: NSNumber(value: duit)) ?? "0")Rupiah"
        kwhElemetn.accessibilityFrameInContainerSpace = viewBg.frame
        elemets.append(kwhElemetn)
        
        self.accessibilityElements = elemets
    }
    
    func setup() {
        
        var kwhTot:Float = 0
        var power:Float = 0
    
        if EnergiesLoad.daily_energy.isEmpty == false {
    
            
            let state = UserData.user[0].power
        
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
                    power = result[lastIndex - i].energy ?? 0
                    kwhTot += power
                    power  = 0
                }
                
            }
            
            var harga: Float = 0
            if state >= 399.0 && state <= 1000.0 {
                harga = 1352
            }else {
                harga = 1440.70
            }

            let duit = "\(Float(Float(kwhTot) * harga))"
            let formatterNumber = NumberFormatter()
            formatterNumber.numberStyle = NumberFormatter.Style.currency
            formatterNumber.locale = Locale(identifier: "id_ID")
            let numberFromField = (NSString(string: duit).integerValue)
            currentSpen.text = formatterNumber.string(from: numberFromField as NSNumber)
            
            setupAccessbility(duit: Int(Float(kwhTot) * harga))
        }
        
       
    }
    
}


