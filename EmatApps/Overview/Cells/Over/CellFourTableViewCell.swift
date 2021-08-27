//
//  CellFourTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

class CellFourTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewRight: UIView!
    
    @IBOutlet weak var kwhStats: UILabel!
    @IBOutlet weak var powerStats: UILabel!
    
    
    let formatter2 = MeasurementFormatter()
    var timer = Timer()
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewLeft.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        viewRight.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        viewLeft.layer.cornerRadius = 8
        viewRight.layer.cornerRadius = 8
                
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupAccessbility(kwh: Float, watt: Float) {
        var elemets = [UIAccessibilityElement]()
        
        let kwhElemetn = UIAccessibilityElement(accessibilityContainer: self)
        kwhElemetn.accessibilityLabel = "Total power usage, \((kwh * 100).rounded()/100 as NSNumber) kilowatt hour"
        kwhElemetn.accessibilityFrameInContainerSpace = viewLeft.frame
        elemets.append(kwhElemetn)
        
        let kwhElemetn2 = UIAccessibilityElement(accessibilityContainer: self)
        kwhElemetn2.accessibilityLabel = "Current usage, \((watt * 100).rounded()/100 as NSNumber) Watt"
        kwhElemetn2.accessibilityFrameInContainerSpace = viewRight.frame
        elemets.append(kwhElemetn2)
        
        self.accessibilityElements = elemets
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
            
        kwhStats.text = kwhTot.toKwhString()
            
        }
        
        if EnergiesLoad.energyModel.isEmpty == false {
            powerStats.text = EnergiesLoad.energyModel[0].power?.toWattString()
            setupAccessbility(kwh: kwhTot, watt: EnergiesLoad.energyModel[0].power ?? 0)
        }
        
        
    }
    
    
}
