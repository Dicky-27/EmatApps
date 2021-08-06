//
//  DailyLoader.swift
//  EmatApps
//
//  Created by Dicky Buwono on 05/08/21.
//

import Foundation

public class DailyLoader {
    
    @Published var daily = [DailyPower]()
    
    init() {
        load()
    }
    
    
    func load() {
            
            if let fileLocation = Bundle.main.url(forResource: "Daily", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: fileLocation)
                    let jsonDecoder = JSONDecoder()
                    let dataFromJson = try jsonDecoder.decode([DailyPower].self, from: data)
                    
                    self.daily = dataFromJson
                } catch {
                    print(error)
                }
            }
        
    }
}
