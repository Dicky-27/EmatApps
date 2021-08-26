//
//  MonthlyReportViewController.swift
//  EmatApps
//
//  Created by Dian Dinihari on 23/08/21.
//

import UIKit
import FSCalendar

class MonthlyReportViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var monthLabel           : UILabel!
    @IBOutlet weak var monthBillLabel       : UILabel!
    @IBOutlet weak var energyUsageLabel     : UILabel!
    @IBOutlet weak var costperDayLabel      : UILabel!
    @IBOutlet weak var dailyHighestLabel    : UILabel!
    @IBOutlet weak var monthlyBudgetLabel   : UILabel!
    @IBOutlet weak var progressBudget       : MonthlyBudget!
    @IBOutlet weak var monthBillCard        : UIView!
    @IBOutlet weak var energyUsageCard      : UIView!
    @IBOutlet weak var averageCostCard      : UIView!
    @IBOutlet weak var dailyHighestCard     : UIView!
    @IBOutlet weak var dailyUsageBanner     : UIView!
    @IBOutlet weak var dailyList            : FSCalendar!
    @IBOutlet weak var indicatorUsage       : UIView!
    @IBOutlet weak var daySelectedLabel     : UILabel!
    @IBOutlet weak var dailyKwhLabel        : UILabel!
    
    
    var monthDetail     : String?
    var monthDetailPow  : Float?
    var monthDetailBill : String?
    var monthBudget     : Float?
    var highestDaily    : Float = 0.0
    var harga           : Float = 1444.70
    var dailyDataList   : [Daily_Energies] = []
    var kwhPower        : Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDailyDataList()
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "DWhite")
        
        dailyList.delegate = self
        dailyList.dataSource = self
        
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
        
        monthBillLabel.shouldGroupAccessibilityChildren = true
        self.dailyList.today = nil

    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd"
        let formattedDate           = dateFormatter.string(from: date)
        let unwrap                  = Date()
        
        var result: [Daily_Energies] = []
        var resultBefore: [Daily_Energies] = []
        
        let dayBefore = Calendar.current.date(byAdding: .day, value: -1, to: date) ?? unwrap
        let dateBefore = dateFormatter.string(from: dayBefore)
        
        result = dailyDataList.filter { ($0.created_at ?? "").contains(formattedDate) }
        resultBefore = dailyDataList.filter { ($0.created_at ?? "").contains(dateBefore) }
        
        dateFormatter.dateFormat = "MMMM d"
        let formatted = dateFormatter.date(from: formattedDate) ?? unwrap
        let strFormat = dateFormatter.string(from: formatted)
        
        if result.isEmpty == false {
            
            if resultBefore.isEmpty == false {
                //Ada data
                daySelectedLabel.text = strFormat
                kwhPower = (result[0].energy ?? 0) - (resultBefore[0].energy ?? 0)
                dailyKwhLabel.text = kwhPower.toKwhString()
            } else {
                //No data di day before
                daySelectedLabel.text = strFormat
                dailyKwhLabel.text = "No data entry"
            }
            
        } else {
            //NO data samsek
            daySelectedLabel.text = strFormat
            dailyKwhLabel.text = "No data entry"
        }
            
        kwhPower = 0
    }
    
    func getDailyDataList(){
        
        APIRequest.fetchDailyEnergyData(url: Constant.GET_DAILY_ENERGY_LIST,showLoader: true) { response in
            // handle response and store it to the data model
            self.dailyDataList = response
            
        } failCompletion: { message in
            print(message)
        }
    }
    
    
}
