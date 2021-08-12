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
    }
    
//    func loadMonthly() {
//        if let fileLocation = Bundle.main.url(forResource: "MonthlyPower", withExtension: "json") {
//            do {
//                let data = try Data(contentsOf: fileLocation)
//                let jsonDecoder = JSONDecoder()
//                let dataFromJson = try jsonDecoder.decode([MonthlyPower].self, from: data)
//
//                self.monthTotal = dataFromJson
//                //print("month total: \(monthTotal)")
//            } catch {
//                print(error)
//            }
//        }
//    }
    func loadMonthly() {
        APIRequest.fetchMonthlyEnergyData(url: Constant.GET_MONTHLY_ENERGY_LIST,showLoader: true) { response in
            // handle response and store it to the data model
            self.monthTotal = response

            DispatchQueue.main.async {
  
            }
            
        } failCompletion: { message in

            print(message)
        }
    }
    
    func getFullData() -> [MonthlyPower] {
        return self.monthTotal
    }
    
    func getPowerList() -> [Float] {
        
        var listPower: [Float] = []
        
        if monthTotal.count > 0 {
            for i in 0...monthTotal.count-1 {
                listPower.append(monthTotal[i].monthly_power)
            }
        }
        
        return listPower
    }
}
