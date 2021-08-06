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
    
    var highestDaily: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyUsageTable.delegate = self
        dailyUsageTable.dataSource = self
        
        monthLabel.text = monthDetail
        monthBillLabel.text = monthDetailBill
        energyUsageLabel.text = String(format: "%.1f kWh", monthDetailPow!)
        monthlyBudgetLabel.text = PowerViewController.budget
        
        //let progCalc1 = Float(PowerViewController.budgetCal / 2)
        //let progCalc2 = progCalc1 / Float(PowerViewController.budgetCal)
        
        //progressBudget.progress = progCalc2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dailyUsageTable.dequeueReusableCell(withIdentifier: "dailyUsageCell") as! DailyUsageTableViewCell
        
        let avgPow = monthDetailPow! / 30.0
        let dailyPow = Float.random(in: avgPow-3.0...avgPow+2.70)
        
        accumulatedPow += dailyPow
        cell.dayLabel.text = dayList[indexPath.row]
        
        if indexPath.row != 29 {
            cell.dailyKwhLabel.text = String(format: "%.2f", dailyPow)
            if highestDaily < dailyPow { highestDaily = dailyPow }
        }
        else {
            var sisaPow : Float = 0.0
            if accumulatedPow >= monthDetailPow! {
                sisaPow = 0.0
            }
            else {
                sisaPow = monthDetailPow! - accumulatedPow
            }
            
            cell.dailyKwhLabel.text = String(format: "%.2f", sisaPow)
            if highestDaily < sisaPow { highestDaily = sisaPow }
        }
        
        if dailyPow < highestDaily {
            cell.indicatorUsage.tintColor = #colorLiteral(red: 0.6039215686, green: 1, blue: 0.4156862745, alpha: 1)
        }else if dailyPow == highestDaily {
            cell.indicatorUsage.tintColor = #colorLiteral(red: 1, green: 0.3882352941, blue: 0.3529411765, alpha: 1)
        }else {
            cell.indicatorUsage.tintColor = #colorLiteral(red: 0.8705882353, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        }
        
        dailyHighestLabel.text = String(format: "%.2f", highestDaily)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // the cell can't be selected on this view
    }
}
