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
            //print("daily response \(response)")
            
            do {
                let energyModel = try JSONDecoder().decode([Energies].self, from: response as! Data)
        
                successCompletion(energyModel)
            } catch let error {
                //handle error
                print("error reading json file content: \(error.localizedDescription)")
            }
        }
    }
    
    static func fetchDailyEnergyData(url: String,
                                showLoader: Bool,
                                successCompletion: @escaping ([Daily_Energies]) -> Void,
                                failCompletion: @escaping (String) -> Void) {
        // create request
        BaseRequest.GET(url: url, showLoader: showLoader) { response in
            //print("daily response \(response)")
            
            do {
                let energyModel = try JSONDecoder().decode([Daily_Energies].self, from: response as! Data)
        
                successCompletion(energyModel)
            } catch let error {
                //handle error
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
            
            do {
                let monthlyEnergyModel = try JSONDecoder().decode([MonthlyPower].self, from: response as! Data)
                
                successCompletion(monthlyEnergyModel)
            } catch let error {
                //handle error
                print("error reading json file content: \(error.localizedDescription)")
            }
        }
    }
    
    static func fetchPredictEnergyData(url: String,
                                       showLoader: Bool,
                                       successCompletion: @escaping ([Predict]) -> Void,
                                       failCompletion: @escaping (String) -> Void) {
        // create request
        BaseRequest.GET(url: url, showLoader: showLoader) { response in
            
            do {
                let predictModel = try JSONDecoder().decode([Predict].self, from: response as! Data)
                
                successCompletion(predictModel)
            } catch let error {
                //handle error
                print("error reading json file content: \(error.localizedDescription)")
            }
        }
    }
}
