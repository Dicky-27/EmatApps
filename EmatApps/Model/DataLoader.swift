//
//  DataLoader.swift
//  EmatApps
//
//  Created by Dicky Buwono on 02/08/21.
//

import Foundation

public class DataLoader {
    
    @Published var powers = [Power]()
    
    init() {
        load()
    }
    
    
    func load() {
            
            if let fileLocation = Bundle.main.url(forResource: "power", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: fileLocation)
                    let jsonDecoder = JSONDecoder()
                    let dataFromJson = try jsonDecoder.decode([Power].self, from: data)
                    
                    self.powers = dataFromJson
                } catch {
                    print(error)
                }
            }
        
    }
    
    /*
     let asset = NSDataAsset(name: "Colors", bundle: Bundle.main)
     let json = try? JSONSerialization.jsonObject(with: asset!.data, options: JSONSerialization.ReadingOptions.allowFragments)
     print(json)
     */
   
}
