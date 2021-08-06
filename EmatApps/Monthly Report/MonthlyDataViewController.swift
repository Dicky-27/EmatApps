//
//  MonthlyDataViewController.swift
//  EmatApps
//
//  Created by Dian Dinihari on 28/07/21.
//

import UIKit

class MonthlyDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var monthBillLabel: UILabel!
    @IBOutlet weak var energyUsageLabel: UILabel!
    @IBOutlet weak var costperDayLabel: UILabel!
    @IBOutlet weak var dailyHighestLabel: UILabel!
    @IBOutlet weak var monthlyBudgetLabel: UILabel!
    @IBOutlet weak var progressBudget: MonthlyBudget!
    @IBOutlet weak var dailyUsageTable: UITableView!
    
    // sample data for list of days
    let dayList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                   "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                   "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]

    var monthDetail     : String?
    var monthDetailPow  : Float?
    var accumulatedPow  : Float = 0.0
    var monthDetailBill : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyUsageTable.delegate = self
        dailyUsageTable.dataSource = self
        
        monthLabel.text = monthDetail
        monthBillLabel.text = monthDetailBill
        energyUsageLabel.text = String(format: "%.1f kWh", monthDetailPow!)
        monthlyBudgetLabel.text = PowerViewController.budget
        progressBudget.progress = PowerViewController.budgetCal
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dailyUsageTable.dequeueReusableCell(withIdentifier: "dailyUsageCell") as! DailyUsageTableViewCell
        let avgPow = monthDetailPow! / 30.0
        let dailyPow = Float.random(in: avgPow-5.0...avgPow+5.0)
        //let maxDaily = max(dailyPow, dailyPow)
        
        accumulatedPow += dailyPow
        
        cell.dailyKwhLabel.text = String(format: "%.2f", dailyPow)
        cell.dayLabel.text = dayList[indexPath.row]
        
        if indexPath.row == 29 {
            let sisaPow: Float = monthDetailPow! - accumulatedPow
            cell.dailyKwhLabel.text = String(format: "%.2f", sisaPow)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // the cell can't be selected on this view
    }
}
