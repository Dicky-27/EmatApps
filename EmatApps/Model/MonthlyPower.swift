//
//  MonthlyPower.swift
//  EmatApps
//
//  Created by Dian Dinihari on 18/08/21.
//

import Foundation

struct MonthlyPower: Codable {
    let id: String
    let month_simple: String
    let month_full: String
    let monthly_power: Float
    let monthly_budget: Float
}
