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
    let dayList         = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                           "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                           "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"
    ]

    var monthDetail     : String?
    var monthDetailPow  : Float?
    var monthDetailBill : String?
    let powFormatter    = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyUsageTable.delegate = self
        dailyUsageTable.dataSource = self
        
        let totalPow = powFormatter.string(from: NSNumber(value: monthDetailPow ?? 0.0))
        
        //progressBudget.progress = PowerViewController.budget
        
        monthLabel.text = monthDetail
        monthBillLabel.text = monthDetailBill
        energyUsageLabel.text = "\(totalPow ?? "0") kWh"
        monthlyBudgetLabel.text = PowerViewController.budget

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dailyUsageTable.dequeueReusableCell(withIdentifier: "dailyUsageCell") as! DailyUsageTableViewCell
        let avgPow = Int((monthDetailPow)! / 30)
        let dailyPow = Int.random(in: avgPow-5...avgPow+5)
        
        cell.dailyKwhLabel.text = powFormatter.string(from: NSNumber(value: dailyPow))
        cell.dayLabel.text = dayList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // the cell can't be selected on this view
    }

}
