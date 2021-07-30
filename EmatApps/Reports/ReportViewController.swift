//
//  ReportViewController.swift
//  EmatApps
//
//  Created by Dian Dinihari on 26/07/21.
//

import UIKit

class ReportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var reportsLabel: UILabel!
    @IBOutlet weak var monthlyComparison: UILabel!
    @IBOutlet weak var monthsLabel: UIStackView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var monthsTable: UITableView!
    
    // months data
    let monthsList = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGraphDisplay()
        
        monthsTable.delegate = self
        monthsTable.dataSource = self
    }
    
    func setupGraphDisplay() {
        
        let maxDayIndex = monthsLabel.arrangedSubviews.count - 1
        
        // Replace last month with that month's actual data
        /* graphView.graphPoints[graphView.graphPoints.count - 1] = */
        
        // refresh the chart
        graphView.setNeedsDisplay()
        
        // Setup date formatter
        let currentMonth = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMM")
        
        // Set up the day name labels with correct days
        for i in 0...maxDayIndex {
            if let date = calendar.date(
                byAdding: .month ,
                value: -i,
                to: currentMonth
            ),
                let label = monthsLabel.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = formatter.string(from: date)
            }
        }
    }
    
    // TableView Things
    // Number of cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthsList.count
    }
    // Content of cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = monthsTable.dequeueReusableCell(withIdentifier: "monthCell") as! MonthsTableViewCell
        
        cell.tableImage.image = #imageLiteral(resourceName: "Card Reports BG (3x)")
        cell.tableImage.layer.cornerRadius = 9
        cell.monthLabel.text = monthsList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // clicked
        if indexPath.section == 2 {
        print("about us selected")
        }
        let monthlyReportSB = UIStoryboard(name: "MonthlyData", bundle: nil)
        let monthlyReportVC = monthlyReportSB.instantiateViewController(withIdentifier: "monthlyData") as! MonthlyDataViewController
        monthlyReportVC.modalPresentationStyle = .fullScreen
        present(monthlyReportVC, animated: true, completion: nil)
    }
}
