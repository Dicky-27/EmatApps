//
//  CellThreeTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

class CellThreeTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var dateNow: UILabel!
    @IBOutlet weak var kwhNumber: UILabel!
    @IBOutlet weak var currentSpen: UILabel!
    
    
    var timer = Timer()
    var count = 0
    
    var power: Float = 0
    var kwh: Float = 0
    var spen: Float = 0
    var harga: Float = 1444.70
    var jam: Float = 24.0
    var duit: Float = 0
    
    let formatter = NumberFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addGradientBackground(firstColor: UIColor(named: "Background") ?? .blue, secondColor: UIColor(named: "White") ?? .white)
       
        viewBg.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "Primary") ?? .white)
    
        viewBg.layer.cornerRadius = 8
        
        
        let date = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: date)
        dateNow.text = "\(calendar.component(.day, from: date)) \(nameOfMonth)"
        
        scheduledTimerWithTimeInterval()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }

    @objc func updateCounting(){
        
        count += 1
        
        //print(DataLoader.init().powers[count].energy)
        //power dibagi 1000
        //power * jam
        //jam = 24
        //duit = kwh * 1.444,70
        // duit asli += spen/3600
        //
        
        
        //print(count)
        
        
        power = DataLoader.init().powers[count].power
        kwh = (power/1000) * jam
        spen = kwh * harga
        duit += spen/3600
        
        let energyValue = Measurement(value: Double(kwh), unit: UnitEnergy.kilowattHours)
        let formatter2 = MeasurementFormatter()
        formatter2.unitOptions = .providedUnit
     
        formatter.locale = Locale(identifier: "id_ID")
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        let formmaterPrice = formatter.string(from: duit as NSNumber)
        
        kwhNumber.text = "\(formatter2.string(from: energyValue))"
        currentSpen.text = "Rp \(formmaterPrice ?? "0") "
        
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
       // gradientLayer.locations = [0.5, 0.5]
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

