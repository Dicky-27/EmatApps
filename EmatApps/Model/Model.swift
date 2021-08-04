//
//  Model.swift
//  EmatApps
//
//  Created by Dian Dinihari on 29/07/21.
//

import Foundation

public class MonthlyData {
    
    @Published var monthTotal = [MonthlyPower]()
    
    init() {
        loadMonthly()
        print("init")
    }
    
    func loadMonthly() {
        if let fileLocation = Bundle.main.url(forResource: "MonthlyPower", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([MonthlyPower].self, from: data)
                
                self.monthTotal = dataFromJson
                print("month total: \(monthTotal)")
            } catch {
                print(error)
            }
        }
    }
    
    func getFullData() -> [MonthlyPower] {
        return self.monthTotal
    }
    
    func getPowerList() -> [Float] {
        
        var listPower: [Float] = []
        for i in 0...monthTotal.count-1 {
            listPower.append(monthTotal[i].monthly_power)
        }
        
        print("list power: \(listPower)")
        return listPower
    }
}
