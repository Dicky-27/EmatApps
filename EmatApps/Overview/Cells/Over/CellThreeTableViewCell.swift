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
        self.addGradientBackground(firstColor: UIColor(named: "Background") ?? .blue, secondColor: UIColor(named: "White") ?? .white)
       
        viewBg.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "Primary") ?? .white)
    
        viewBg.layer.cornerRadius = 8
        
        
//        let date = Date()
//        let calendar = Calendar.current
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "LLLL"
//        let nameOfMonth = dateFormatter.string(from: date)
//        dateNow.text = "\(calendar.component(.day, from: date)) \(nameOfMonth)"

        formatter.locale = Locale(identifier: "id_ID")
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
//   gett()
    //    scheduledTimerWithTimeInterval()
//
//        isoDate = DataLoader.init().powers[count].created_at
//        isoDate2 = DataLoader.init().powers[count + 1].created_at
//
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss.SSSSSSZ"
//        let date = dateFormatter.date(from: isoDate)
//        let date2 = dateFormatter.date(from: isoDate2)
//        let seconds = date2?.timeIntervalSince(date ?? date3)
//
//        let hour = seconds ?? 0/3600
//
//        power = DataLoader.init().powers[count].power
//        kwh = (power/1000) * Float(hour)
//        spen = kwh * harga
//        duit += spen/3600
        
       // let test = 40849.5214834126666666666666661851


       // let energyValue = Measurement(value: Double(kwh), unit: UnitEnergy.kilowattHours)
       // let formmaterPrice = formatter.string(from: test as NSNumber)

      //  kwhNumber.text = "\(formatter2.string(from: energyValue))"
        //currentSpen.text = "Rp \(formmaterPrice ?? "0") "
        

        //updateLabel()
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
        
        let randomfloat = Double.random(in: 2000...2200)
        let hour: Double = 1/3600
        let kwhnya = Double(randomfloat/1000 * hour)
        
        
        //  (x*100).rounded()/100
       // let spen2 = kwhnya * harga
       // let pr += spen2/3600
        
        let energyValue = Measurement(value: kwhnya, unit: UnitEnergy.kilowattHours)
        formatter2.unitOptions = .providedUnit
        
        // let formmaterPrice = formatter.string(from: pr as NSNumber)
//        print(kw2)
//        print(randomfloat)
        print(kwhnya)
        print(formatter2.string(from: energyValue))
        
        
       // currentSpen.text = "\(DataLoader.init().powers[count].power)"
        
        // let energyValue = Measurement(value: Double(kwh), unit: UnitEnergy.kilowattHours)
        // let formmaterPrice = formatter.string(from: test as NSNumber)

        
      //  kwhNumber.text = formatter2.string(from: energyValue)
       // currentSpen.text = "Rp \(formmaterPrice ?? "0")"
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

