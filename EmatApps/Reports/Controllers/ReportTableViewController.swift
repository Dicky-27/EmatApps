//
//  ReportTableViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 12/08/21.
//

import UIKit

class ReportTableViewController: UITableViewController {

    
    let rupiahFormatter = NumberFormatter()
    let allMonthData            = MonthlyData.init()
    var isidata: [MonthlyPower] = []
    var harga: Float            = 1444.70 //predefine price per kwh
    
    var monthlyDataList: [MonthlyPower] = []
    
    lazy var titleStackView: TitleView = {
                let titleStackView = TitleView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 40.0)))
                titleStackView.translatesAutoresizingMaskIntoConstraints = false
                return titleStackView
            }()
    
            lazy var tableHeaderView: UIView = {
                let tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 40.0)))
                tableHeaderView.backgroundColor = UIColor(named: "Wblack")
                tableHeaderView.addSubview(titleStackView)
                titleStackView.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: 16.0).isActive = true
                titleStackView.topAnchor.constraint(equalTo: tableHeaderView.topAnchor).isActive = true
                titleStackView.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: -16.0).isActive = true
                titleStackView.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor).isActive = true
                
                return tableHeaderView
            }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMonthlyData()
        tableView.separatorStyle = .none
        
        navigationItem.title = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        tableView.tableHeaderView = tableHeaderView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }else {
            return monthlyDataList.count
        }
       
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GrafTableViewCell
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as! ListTableViewCell
        
        if indexPath.section == 0 {
            
            let maxDayIndex = cell.monthsLabel.arrangedSubviews.count - 1
            
            // refresh the chart
            cell.graph.setNeedsDisplay()
            cell.graph.layer.cornerRadius = 8
            cell.graph.layer.borderWidth = 1
            cell.graph.layer.borderColor = UIColor.clear.cgColor
            cell.graph.layer.masksToBounds = true
            
            // Setup date formatter for month label
            //let currentMonth = Date()
            //let calendar     = Calendar.current
            let formatter    = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("MMM")
            
            // Set up the month name labels with sorted months
            
            for i in 0..<monthlyDataList.count {
                if let label = cell.monthsLabel.arrangedSubviews[maxDayIndex - i] as? UILabel {
                    label.text = monthlyDataList[i].month_simple
                }
            }
            
            cell.selectionStyle = .none
            
            return cell
        }else {
            
            if monthlyDataList.count != 0 {
                
                rupiahFormatter.numberStyle           = .decimal
                rupiahFormatter.groupingSeparator     = "."
                rupiahFormatter.maximumFractionDigits = 0

                let totalSpend  = monthlyDataList[indexPath.row].monthly_power * harga              //rupiahLabel calc
                let rupiahPower = rupiahFormatter.string(from: NSNumber(value: totalSpend)) //change totalspend to string
                let kwhPower    = String(monthlyDataList[indexPath.row].monthly_power)              //change kwh to string

                //displaying all the labels
                cell2.tableImage.layer.cornerRadius    = 9
                cell2.monthLabel.text                  = monthlyDataList[indexPath.row].month_full
                cell2.kwhLabel.text                    = "\(kwhPower) kWh"
                cell2.rupiahLabel.text                 = "Rp \(rupiahPower ?? "0")"
                cell2.selectionStyle                   = .none
                
                
            }
            
            return cell2
        }

        // Configure the cell...

        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 260
        }else {
            return 100
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxTitlePoint = tableView.convert(CGPoint(x: titleStackView.titleLabel.bounds.minX, y: titleStackView.titleLabel.bounds.maxY), from: titleStackView.titleLabel)

        navigationItem.title = scrollView.contentOffset.y > maxTitlePoint.y ? "Report" : nil
        tabBarItem.title = scrollView.contentOffset.y > maxTitlePoint.y ? "Report" : "Overview"
        
     }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rupiahFormatter.numberStyle           = .decimal
        rupiahFormatter.groupingSeparator     = "."
        rupiahFormatter.maximumFractionDigits = 0
        
        let totalSpend  = monthlyDataList[indexPath.row].monthly_power * harga              //rupiahLabel calc
        let rupiahPower = rupiahFormatter.string(from: NSNumber(value: totalSpend)) //change totalspend to string

        // clicked
        if indexPath.section == 2 {
            print("about us selected")
        }
        
        let row = indexPath.row
        let dataParam : [String : Any] = [
            "isiData" : monthlyDataList[row],
            "rupiahPower" : rupiahPower as Any
        ]
        
        performSegue(withIdentifier: "toDetail", sender: dataParam)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
            if let detailVC = segue.destination as? MonthlyDataViewController {
                
                let dataPowFull = sender as! [String : Any]
                let dataPow : MonthlyPower = dataPowFull["isiData"] as! MonthlyPower
                let rupiahPower = dataPowFull["rupiahPower"] as? String
                
                detailVC.monthDetail = dataPow.month_full
                detailVC.monthDetailPow = dataPow.monthly_power
                detailVC.monthDetailBill = rupiahPower
                detailVC.monthBudget = dataPow.monthly_budget
                
            }
        }
    }
    
    func getMonthlyData(){
        
        APIRequest.fetchMonthlyEnergyData(url: Constant.GET_MONTHLY_ENERGY_LIST,showLoader: true) { response in
            
            // handle response and store it to the data model
            //print(response)
            self.monthlyDataList = response
            
           
            DispatchQueue.main.async {
               // self.setData()
                self.tableView.reloadData()
                //self.removeLoadingScreen()
            }
            
        } failCompletion: { message in
            // display alert failure
            // dismiss loader
           print(message)
        }
    }

}
