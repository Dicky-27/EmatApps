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
    
    func setup() {
        
        var kwhTot:Float = 0
        var power:Float = 0
    
        if EnergiesLoad.energyModel.isEmpty == false {
    
            for i in 0..<EnergiesLoad.energyModel.count{

                power = EnergiesLoad.energyModel[i].power ?? 0
                kwhTot += power/1000
                
            }
            
            let state = UserData.user[0].budget
        
            var harga: Float = 0
            if state >= 399.0 && state <= 1000.0 {
                harga = 1352
            }else {
                harga = 1440.70
            }

            let duit = "\(Float(Float(kwhTot) * harga))"
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.currency
            formatter.locale = Locale(identifier: "id_ID")
            let numberFromField = (NSString(string: duit).integerValue)
            currentSpen.text = formatter.string(from: numberFromField as NSNumber)
            
        }
    }
    
}

extension UIView{
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0.5, 0.5]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addGradientBackground2(firstColor: UIColor, secondColor: UIColor){
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}


extension UnitEnergy {
    
    static let wattHours = UnitEnergy(symbol: "Wh", converter: UnitConverterLinear(coefficient:3600))
    
    static let megaWattHours = UnitEnergy(symbol: "mWh", converter: UnitConverterLinear(coefficient:3600000000))
    
    static let gigaWattHours = UnitEnergy(symbol: "gWh", converter: UnitConverterLinear(coefficient:3600000000000))
    
    
    
}

extension Measurement where UnitType: Dimension {
    
    func scaled (scales:[UnitType], target: Double) -> Measurement {
        guard !scales.isEmpty else {
            return self
        }
        var returnMeasure = self.converted(to: scales.first!)
        if returnMeasure.value.magnitude > target {
            
            for unit in scales {
                returnMeasure.convert(to: unit)
                if returnMeasure.value.magnitude < target {
                    break
                }
            }
        }
        return returnMeasure
    }
}

