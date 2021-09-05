//
//  CircleMarker.swift
//  EmatApps
//
//  Created by Dicky Buwono on 05/08/21.
//

import Foundation
import UIKit

struct Loading {
    
    static let loadingView = UIView()
    static let spinner = UIActivityIndicatorView()
    static let loadingLabel = UILabel()
    static let viewBaru = UIView()
   
}


struct UserData {
    static var user = [User]()
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}


struct EnergiesLoad {
    static var energyModel: [Energies] = []
    static var daily_energy: [Daily_Energies] = []
    static var predictEnergy: [Predict] = []
}
