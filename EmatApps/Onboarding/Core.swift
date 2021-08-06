//
//  Core.swift
//  EmatApps
//
//  Created by Dicky Buwono on 06/08/21.
//

import Foundation

class Core {
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUsert() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
