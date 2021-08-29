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
    @IBOutlet weak var averageCostLabel     : UILabel!
    @IBOutlet weak var dailyHighestLabel    : UILabel!
    @IBOutlet weak var monthlyBudgetLabel   : UILabel!
    @IBOutlet weak var progressBudget       : MonthlyBudget!
    @IBOutlet weak var dailyUsageTable      : UITableView!
    @IBOutlet weak var monthBillCard        : UIView!
    @IBOutlet weak var energyUsageCard      : UIView!
    @IBOutlet weak var averageCostCard      : UIView!
    @IBOutlet weak var dailyHighestCard     : UIView!
    @IBOutlet weak var dailyUsageBanner     : UIView!
    @IBOutlet weak var leftLabel            : UILabel!
    @IBOutlet weak var monthBill            : UILabel!
    @IBOutlet weak var energyUsage          : UILabel!
    @IBOutlet weak var averageCost          : UILabel!
    @IBOutlet weak var dailyHigh            : UILabel!
    @IBOutlet weak var dailyUse             : UILabel!
    
    // Properties
    var monthDetail     : String?
    var monthDetailPow  : Float?
    var monthDetailBill : String?
    var monthBillNumber : Float = 0.0
    var monthBudget     : Float?
    var highestDaily    : Float = 0.0
    var dailyBudget     : Float = 0.0
    var harga           : Float = 1444.70
    var dailyDataList   : [Daily_Energies] = []
    var monthlyDataList : [MonthlyPower] =  []
    var prevEnergy      : Float = 0
    var todayEnergy     : Float = 0
    var currEnergy      : Float = 0
    var maxDailyCost    : Float = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyBudget = (monthBudget ?? 0.0) / 30 / harga
        let percentBill = (monthBillNumber ) / (monthBudget ?? 0.0)
        progressBudget.progress = percentBill
        getDailyDataList()
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "DWhite")
        
        dailyUsageTable.delegate   = self
        dailyUsageTable.dataSource = self
        
        monthLabel.text         = monthDetail
        monthBillLabel.text     = monthDetailBill
        energyUsageLabel.text   = monthDetailPow?.toKwhString()
        monthlyBudgetLabel.text = monthBudget?.toRupiahString()
        
        view.addGradientBackground(firstColor: UIColor(named: "Background") ?? .blue, secondColor: UIColor(named: "Wblack") ?? .white)
        monthBillCard.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        energyUsageCard.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        averageCostCard.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        dailyHighestCard.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
        dailyUsageBanner.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if monthDetail == "August" {
            return dailyDataList.count
        }
        else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dailyUsageTable.dequeueReusableCell(withIdentifier: "dailyUsageCell") as! DailyUsageTableViewCell
        
        if monthDetail == "August" && dailyDataList.count != 0 {
            
            maxDailyCost    = highestDaily * harga
            let maxDailyStr = maxDailyCost.toRupiahString()
            
            todayEnergy = dailyDataList[indexPath.row].energy ?? 0.0
            currEnergy  = todayEnergy - prevEnergy
            
            let dayLabel                = dailyDataList[indexPath.row].created_at
            let dayLabelArr             = dayLabel?.components(separatedBy: " ")
            let dayLabelDate: String    = dayLabelArr?[0].components(separatedBy: "-")[2] ?? ""
            
            if currEnergy > highestDaily {
                highestDaily = currEnergy
                accessibilityHelper()
            }
            
            cell.dayLabel.text = dayLabelDate
            cell.dailyKwhLabel.text = currEnergy.toKwhString()
            
            switch currEnergy {
            case _ where currEnergy == 0:
                cell.indicatorUsage.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
            case _ where currEnergy <= dailyBudget :
                cell.indicatorUsage.backgroundColor = #colorLiteral(red: 0.6039215686, green: 1, blue: 0.4156862745, alpha: 1)
            case _ where currEnergy > dailyBudget:
                cell.indicatorUsage.backgroundColor = #colorLiteral(red: 1, green: 0.3882352941, blue: 0.3529411765, alpha: 1)
            default:
                cell.indicatorUsage.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }

            averageCostLabel.text   = maxDailyStr
            dailyHighestLabel.text  = highestDaily.toKwhString()
            prevEnergy              = currEnergy
            
            return cell
        }
        else { return cell }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // the cell can't be selected on this view
    }
    
    func getDailyDataList(){
        
        APIRequest.fetchDailyEnergyData(url: Constant.GET_DAILY_ENERGY_LIST,showLoader: true) { response in
            // handle response and store it to the data model
            self.dailyDataList = response
            self.dailyDataList.reverse()
            
            DispatchQueue.main.async {
                self.dailyUsageTable.reloadData()
            }
        } failCompletion: { message in
            print(message)
        }
    }
    
    func accessibilityHelper() {
        
        let formatterRp = NumberFormatter()
        formatterRp.numberStyle = NumberFormatter.Style.spellOut
        formatterRp.locale = Locale(identifier: "en_ID")
        formatterRp.maximumFractionDigits = 0
        
        let formatterPercent = NumberFormatter()
        formatterPercent.numberStyle = .percent
        
        let formatterKwh = NumberFormatter()
        formatterKwh.numberStyle = .decimal
        formatterKwh.locale = Locale(identifier: "en_ID")
        formatterKwh.maximumFractionDigits = 2
        formatterKwh.minimumFractionDigits = 2
        
        
        monthLabel.isAccessibilityElement = true
        monthLabel.accessibilityTraits = .none
        monthLabel.accessibilityLabel = "\(monthDetail ?? "") Report"
        
        monthBill.isAccessibilityElement = false
        monthBillLabel.isAccessibilityElement = false
        monthBillCard.isAccessibilityElement = true
        monthBillCard.accessibilityLabel = "Month Bill Total, \(formatterRp.string(from: NSNumber(value: (monthBillNumber).rounded())) ?? "0")Rupiah"
        
        energyUsage.isAccessibilityElement = false
        energyUsageLabel.isAccessibilityElement = false
        energyUsageCard.isAccessibilityElement = true
        energyUsageCard.accessibilityLabel = "Energy Usage Total, \(formatterRp.string(from: NSNumber(value: (monthDetailPow ?? 0.0).rounded())) ?? "0") kilowatt hour"
        
        averageCost.isAccessibilityElement = false
        averageCostLabel.isAccessibilityElement = false
        averageCostCard.isAccessibilityElement = true
        averageCostCard.accessibilityLabel = "Average Cost Daily, \(formatterRp.string(from: NSNumber(value: (maxDailyCost).rounded())) ?? "0")Rupiah"
        
        dailyHigh.isAccessibilityElement = false
        dailyHighestLabel.isAccessibilityElement = false
        dailyHighestCard.isAccessibilityElement = true
        dailyHighestCard.accessibilityLabel = "Highest Energy Daily, \(formatterKwh.string(from: NSNumber(value: highestDaily)) ?? "0") kilowatt hour"
        
        leftLabel.isAccessibilityElement = false
        monthlyBudgetLabel.isAccessibilityElement = false
        progressBudget.isAccessibilityElement = true
        progressBudget.accessibilityLabel = "This Month Budget is, \(formatterRp.string(from: NSNumber(value: monthBudget ?? 0)) ?? "0")Rupiah, this month spending progress is, \(formatterPercent.string(from: NSNumber(value: progressBudget.progress)) ?? "0")"
        
        
    }
}


