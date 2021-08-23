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
    var accumulatedPow  : Float = 0.0
    var monthDetailBill : String?
    var monthBudget     : Float?
    var highestDaily    : Float = 0.0
    var harga           : Float = 1444.70
    var dailyDataList   : [Daily_Energies] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        //getKwhDaily()
        
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        let formattedDate        = dateFormatter.string(from: date)
        
        let dailyIndex = dailyDataList.count - 1
        var dailyPow: Float = 0.0
        
        for i in 0..<dailyDataList.count {
            
            dailyPow = dailyDataList[dailyIndex - i].power ?? 0.0
            
        }
        
        daySelectedLabel.text   = formattedDate
        dailyKwhLabel.text      = dailyPow.toKwhString()
    
    }
    
//    func getKwhDaily() {
//
//        let dailyIndex = dailyDataList.count - 1
//
//        for i in 0..<dailyDataList.count {
//
//            var dailyPow = dailyDataList[dailyIndex - i].power
//
//        }
//    }
    
    func getDailyDataList(){
        
        APIRequest.fetchDailyEnergyData(url: Constant.GET_DAILY_ENERGY_LIST,showLoader: true) { response in
            
            // handle response and store it to the data model
            self.dailyDataList = response
            
            DispatchQueue.main.async {
                
            }
            
        } failCompletion: { message in
            
            print(message)
        }
    }
    
    
}
