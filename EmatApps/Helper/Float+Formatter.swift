//
//  String+Formatter.swift
//  EmatApps
//
//  Created by Dian Dinihari on 18/08/21.
//

import Foundation

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

