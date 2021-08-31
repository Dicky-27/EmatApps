//
//  String+Formatter.swift
//  EmatApps
//
//  Created by Dian Dinihari on 18/08/21.
//

import Foundation
import UIKit

extension Float {
    
    func toRupiahString() -> String {
        
        let rupiahFormat = NumberFormatter()
        
        rupiahFormat.numberStyle = .decimal
        rupiahFormat.groupingSeparator = "."
        rupiahFormat.maximumFractionDigits = 0
        
        return "Rp\(rupiahFormat.string(from: NSNumber(value: self)) ?? "0")"
    }
    
    func toKwhString() -> String {
        
        let kwhFormat = NumberFormatter()
        
        kwhFormat.numberStyle = .decimal
        kwhFormat.decimalSeparator = ","
        kwhFormat.minimumFractionDigits = 2
        kwhFormat.maximumFractionDigits = 2
        
        return "\(kwhFormat.string(from: NSNumber(value:self)) ?? "0,00") kWh"
    }
    
    func toWattString() -> String {
        
        let kwhFormat = NumberFormatter()
        
        kwhFormat.numberStyle = .decimal
        kwhFormat.decimalSeparator = ","
        kwhFormat.minimumFractionDigits = 2
        kwhFormat.maximumFractionDigits = 2
        
        return "\(kwhFormat.string(from: NSNumber(value:self)) ?? "0,00") Watt"
    }
    
    func accRupiahFormater() -> String {
        let formatterRp = NumberFormatter()
        formatterRp.numberStyle = NumberFormatter.Style.spellOut
        formatterRp.locale = Locale(identifier: "en_ID")
        formatterRp.maximumFractionDigits = 0
        
        return "\(formatterRp.string(from: NSNumber(value: self)) ?? "0")Rupiah"
    }
    
    func accKwhFormatter() -> String {
        let formatterKwh = NumberFormatter()
        formatterKwh.numberStyle = .decimal
        formatterKwh.locale = Locale(identifier: "en_ID")
        formatterKwh.maximumFractionDigits = 2
        formatterKwh.minimumFractionDigits = 2
        
        return "\(formatterKwh.string(from: NSNumber(value: self)) ?? "0") Kilowatt Hour"
    }
    
    func accPercentFormatter() -> String {
        let formatterPercent = NumberFormatter()
        formatterPercent.numberStyle = .percent
        
        return "\(formatterPercent.string(from: NSNumber(value: self)) ?? "0")"
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

