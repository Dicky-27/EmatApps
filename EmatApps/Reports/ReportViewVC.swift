//
//  ReportViewVC.swift
//  EmatApps
//
//  Created by Dian Dinihari on 03/08/21.
//

import UIKit

class ReportViewVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var reportsLabel: UILabel!
    @IBOutlet weak var monthlyComparison: UILabel!
    @IBOutlet weak var monthsLabel: UIStackView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var monthsTable: UITableView!
    
    let rupiahFormatter = NumberFormatter()
    
    //get the data from MonthlyPower.json
    let allMonthData            = MonthlyData.init()
    var isidata: [MonthlyPower] = []
    var harga: Float            = 1444.70 //predefine price per kwh
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthsTable.delegate   = self
        monthsTable.dataSource = self
        
        //load all data from the object contained the json
        allMonthData.loadMonthly()
        isidata = allMonthData.getFullData()
        
        //showing the chart
        setupGraphDisplay()
    }
    
    func setupGraphDisplay() {
        
        let maxDayIndex = monthsLabel.arrangedSubviews.count - 1
        
        // refresh the chart
        graphView.setNeedsDisplay()
        
        // Setup date formatter for month label
        let currentMonth = Date()
        let calendar     = Calendar.current
        let formatter    = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMM")
        
        // Set up the month name labels with sorted months
        for i in 0...isidata.count-1 {
            if let date = calendar.date(
                byAdding: .month ,
                value: -i,
                to: currentMonth
            ),
            let label = monthsLabel.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = isidata[i].month_simple
            }
        }
    }
    
    // TableView Things
    // Number of cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isidata.count
    }
    // Content of cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //formatter for rupiah from calculation
        rupiahFormatter.numberStyle           = .decimal
        rupiahFormatter.groupingSeparator     = "."
        rupiahFormatter.maximumFractionDigits = 0
        
        let cell        = monthsTable.dequeueReusableCell(withIdentifier: "monthCell") as! MonthsTableViewCell
        let totalSpend  = isidata[indexPath.row].monthly_power * harga              //rupiahLabel calc
        let rupiahPower = rupiahFormatter.string(from: NSNumber(value: totalSpend)) //change totalspend to string
        let kwhPower    = String(isidata[indexPath.row].monthly_power)              //change kwh to string
        
        //displaying all the labels
        cell.tableImage.image                 = #imageLiteral(resourceName: "Card Reports BG (3x)")
        cell.tableImage.layer.cornerRadius    = 9
        cell.monthLabel.text                  = isidata[indexPath.row].month_full
        cell.kwhLabel.text                    = "\(kwhPower) kWh"
        cell.rupiahLabel.text                 = "Rp \(rupiahPower ?? "0")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        rupiahFormatter.numberStyle           = .decimal
        rupiahFormatter.groupingSeparator     = "."
        rupiahFormatter.maximumFractionDigits = 0
        
        let totalSpend  = isidata[indexPath.row].monthly_power * harga              //rupiahLabel calc
        let rupiahPower = rupiahFormatter.string(from: NSNumber(value: totalSpend)) //change totalspend to string

        // clicked
        if indexPath.section == 2 {
            print("about us selected")
        }
        
        let monthlyReportSB = UIStoryboard(name: "MonthlyData", bundle: nil)
        let monthlyReportVC = monthlyReportSB.instantiateViewController(withIdentifier: "monthlyData") as! MonthlyDataViewController
        
        monthlyReportVC.monthDetail            = self.isidata[indexPath.row].month_full
        monthlyReportVC.monthDetailPow         = self.isidata[indexPath.row].monthly_power
        monthlyReportVC.monthDetailBill        = rupiahPower
        monthlyReportVC.modalPresentationStyle = .fullScreen
        
        present(monthlyReportVC, animated: true, completion: nil)
        
        
    }
}