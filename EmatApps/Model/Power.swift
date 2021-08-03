//
//  Power.swift
//  EmatApps
//
//  Created by Dicky Buwono on 02/08/21.
//

import Foundation

struct Power: Codable {
    let id: String
    let created_at: String
    let energy: Float
    let power: Float
    let voltage: Float
    let current: Float
    let frequency: Float
    let power_factor: Float
    
}

struct MonthlyPower: Codable {
    let id: String
    let month_simple: String
    let month_full: String
    let monthly_power: Float
}


/*
 
 "id": "2ebeb9e2-9d7d-11eb-a902-acde48001122",
 "created_at": "2021-04-15 06:57:34.565666+07:00",
 "energy": 0.001,
 "power": 30.0,
 "voltage": 220.25,
 "current": 0.05,
 "frequency": 50.0,
 "power_factor": 0.9
 
 
 */
