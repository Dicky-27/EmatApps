//
//  Helper.swift
//  EmatApps
//
//  Created by Dian Dinihari on 13/08/21.
//

import Foundation


class Helper {
    
    static func rpFormatter(number: Float) -> String {
        
        let rupiahFormat = NumberFormatter()
        
        rupiahFormat.numberStyle = .decimal
        rupiahFormat.groupingSeparator = "."
        rupiahFormat.maximumFractionDigits = 0
        
        let finalString = "Rp\(rupiahFormat.string(from: NSNumber(value: number)) ?? "0")"
        
        return finalString
    }
    
    static func kwhFormatter(number: Float) -> String {
        
        let kwhFormat = NumberFormatter()
        
        kwhFormat.numberStyle = .decimal
        kwhFormat.decimalSeparator = ","
        kwhFormat.minimumFractionDigits = 2
        kwhFormat.maximumFractionDigits = 2
        let finalString = "\(kwhFormat.string(from: NSNumber(value:number)) ?? "0,00") kWh"
        
        return finalString
    }
    
    static func wattFormatter(number: Float) -> String {
        
        let kwhFormat = NumberFormatter()
        
        kwhFormat.numberStyle = .decimal
        kwhFormat.decimalSeparator = ","
        kwhFormat.minimumFractionDigits = 2
        kwhFormat.maximumFractionDigits = 2
        let finalString = "\(kwhFormat.string(from: NSNumber(value:number)) ?? "0,00") Watt"
        
        return finalString
    }

}
