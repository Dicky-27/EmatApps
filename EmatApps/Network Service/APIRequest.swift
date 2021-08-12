//
//  APIRequest.swift
//  EmatApps
//
//  Created by Dicky Buwono on 06/08/21.
//

import Foundation

class APIRequest: NSObject {
    
    static func fetchEnergyData(url: String,
                                  showLoader: Bool,
                                  successCompletion: @escaping ([Energies]) -> Void,
                                  failCompletion: @escaping (String) -> Void) {
        // create request
        BaseRequest.GET(url: url, showLoader: showLoader) { response in
            print("daily response \(response)")
         
            do {
                let energyModel = try JSONDecoder().decode([Energies].self, from: response as! Data)
               // dataModel = energyModel
                successCompletion(energyModel)
            } catch let error { //handle error
                print("error reading json file content: \(error.localizedDescription)")
            }
        }
    }
    
    static func fetchMonthlyEnergyData(url: String,
                                  showLoader: Bool,
                                  successCompletion: @escaping ([MonthlyPower]) -> Void,
                                  failCompletion: @escaping (String) -> Void) {
        // create request
        BaseRequest.GET(url: url, showLoader: showLoader) { response in
            //print(response)
         
            do {
                let monthlyEnergyModel = try JSONDecoder().decode([MonthlyPower].self, from: response as! Data)
               // dataModel = energyModel
                successCompletion(monthlyEnergyModel)
            } catch let error { //handle error
                print("error reading json file content: \(error.localizedDescription)")
            }
        }
    }
    
}
