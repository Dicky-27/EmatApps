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
    
    let dayCount = ["1", "2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyUsageTable.delegate = self
        dailyUsageTable.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dayCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dailyUsageTable.dequeueReusableCell(withIdentifier: "dailyUsageCell") as! DailyUsageTableViewCell
        
        cell.dayLabel.text = dayCount[indexPath.row]
        
        return cell
    }
    
}
