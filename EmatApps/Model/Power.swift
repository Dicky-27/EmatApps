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
    let monthly_budget: Float
}

struct DailyPower: Codable {
    let energy_july: Float
    let energy_agus: Float
}

struct Energies: Codable {
    let id: String?
    let created_at: String?
    let energy: Float?
    let power: Float?
    let voltage: Float?
    let current: Float?
    let frequency: Float?
    let power_factor: Float?
}
