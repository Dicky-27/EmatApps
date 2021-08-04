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
    let dayList         = ["1", "2"]

    var monthDetail     : String?
    var monthDetailPow  : Float?
    var monthDetailBill : String?
    //var monthTargetBill : Float?
    let powFormatter    = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyUsageTable.delegate = self
        dailyUsageTable.dataSource = self
        
        let totalPow = powFormatter.string(from: NSNumber(value: monthDetailPow ?? 0.0))
        
        monthLabel.text = monthDetail
        monthBillLabel.text = monthDetailBill
        energyUsageLabel.text = "\(totalPow ?? "0") kWh"
        monthlyBudgetLabel.text = powFormatter.string(from: NSNumber(value: TargetBill.inputedBill ?? 0.0))

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dailyUsageTable.dequeueReusableCell(withIdentifier: "dailyUsageCell") as! DailyUsageTableViewCell
        
        cell.dayLabel.text = dayList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // the cell can't be selected on this view
    }
    
}
