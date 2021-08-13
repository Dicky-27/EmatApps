//
//  MonthlyDataViewController.swift
//  EmatApps
//
//  Created by Dian Dinihari on 28/07/21.
//

import UIKit

class MonthlyDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var monthLabel           : UILabel!
    @IBOutlet weak var monthBillLabel       : UILabel!
    @IBOutlet weak var energyUsageLabel     : UILabel!
    @IBOutlet weak var costperDayLabel      : UILabel!
    @IBOutlet weak var dailyHighestLabel    : UILabel!
    @IBOutlet weak var monthlyBudgetLabel   : UILabel!
    @IBOutlet weak var progressBudget       : MonthlyBudget!
    @IBOutlet weak var dailyUsageTable      : UITableView!
    @IBOutlet weak var monthBillCard        : UIView!
    @IBOutlet weak var energyUsageCard      : UIView!
    @IBOutlet weak var averageCostCard      : UIView!
    @IBOutlet weak var dailyHighestCard     : UIView!
    @IBOutlet weak var dailyUsageBanner     : UIView!
    
    // sample data for list of days
    let dayList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
                   "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",
                   "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]

    var monthDetail     : String?
    var monthDetailPow  : Float?
    var accumulatedPow  : Float = 0.0
    var monthDetailBill : String?
    var monthBudget     : Float?
    var highestDaily    : Float = 0.0
    var harga           : Float = 1444.70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "DWhite")
        dailyUsageTable.delegate   = self
        dailyUsageTable.dataSource = self
        
        monthLabel.text         = monthDetail
        monthBillLabel.text     = monthDetailBill
        energyUsageLabel.text   = Helper.kwhFormatter(number: monthDetailPow ?? 0)
        monthlyBudgetLabel.text = Helper.rpFormatter(number: monthBudget ?? 0)
        
        view.addGradientBackground(firstColor: UIColor(named: "Background") ?? .blue, secondColor: UIColor(named: "Wblack") ?? .white)
        monthBillCard.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        energyUsageCard.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        averageCostCard.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        dailyHighestCard.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        dailyUsageBanner.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dailyUsageTable.dequeueReusableCell(withIdentifier: "dailyUsageCell") as! DailyUsageTableViewCell
        
        var dailyPow: Float = 0.0
        let avgPow          = monthDetailPow! / 30.0
        let maxDailyCost    = highestDaily * harga
        let maxDailyStr     = Helper.rpFormatter(number: maxDailyCost)
        
        if avgPow == 0 {
            dailyPow = 0.0
        }
        else {
         dailyPow = Float.random(in: avgPow-3.0...avgPow+2.70)
        }
        
        accumulatedPow += dailyPow
        cell.dayLabel.text = dayList[indexPath.row]
        
        if indexPath.row != 29 {
            cell.dailyKwhLabel.text = Helper.kwhFormatter(number: dailyPow)
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
            
            cell.dailyKwhLabel.text = Helper.kwhFormatter(number: sisaPow)
            if highestDaily < sisaPow { highestDaily = sisaPow }
        }

        switch dailyPow {
        case _ where dailyPow == 0:
            cell.indicatorUsage.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
            progressBudget.progress = 0.0
        case _ where dailyPow < highestDaily:
            cell.indicatorUsage.backgroundColor = #colorLiteral(red: 0.6039215686, green: 1, blue: 0.4156862745, alpha: 1)
            progressBudget.progress = 1.0
        case _ where dailyPow >= highestDaily:
            cell.indicatorUsage.backgroundColor = #colorLiteral(red: 1, green: 0.3882352941, blue: 0.3529411765, alpha: 1)
            progressBudget.progress = 0.0
        default:
            cell.indicatorUsage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            progressBudget.progress = 0.0
        }

        costperDayLabel.text    = maxDailyStr
        dailyHighestLabel.text  = Helper.kwhFormatter(number: highestDaily)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // the cell can't be selected on this view
    }
}


