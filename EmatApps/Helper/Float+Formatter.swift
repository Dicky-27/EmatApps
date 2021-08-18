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
}
