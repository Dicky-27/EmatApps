//
//  ReportTableViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 12/08/21.
//

import UIKit

class ReportTableViewController: UITableViewController {
    
    let loadingView     = UIView()
    let spinner         = UIActivityIndicatorView()
    let loadingLabel    = UILabel()
    var harga: Float    = 1444.70 //predefine price per kwh
    
    var monthlyDataList: [MonthlyPower] = []
    
    lazy var titleStackView: TitleView = {
        
        let titleStackView = TitleView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 40.0)))
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.isAccessibilityElement   = true
        titleStackView.accessibilityLabel       = "Report Page"
        
        return titleStackView
    }()
    
    lazy var tableHeaderView: UIView = {
        
        let tableHeaderView             = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 40.0)))
        tableHeaderView.backgroundColor = UIColor(named: "Wblack")
        tableHeaderView.addSubview(titleStackView)
        
        titleStackView.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: 16.0).isActive    = true
        titleStackView.topAnchor.constraint(equalTo: tableHeaderView.topAnchor).isActive                            = true
        titleStackView.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: -16.0).isActive = true
        titleStackView.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor).isActive                      = true
        
        return tableHeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = nil
        navigationController?.navigationBar.shadowImage = UIImage()
        
        tableView.tableHeaderView = tableHeaderView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.refreshControl?.attributedTitle = .none
        
        setPullToRequest()
        setLoadingScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "Wblack")
        
        
        getMonthlyData()
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
        } else {
            return monthlyDataList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell") as! GrafTableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as! ListTableViewCell
        
        if indexPath.section == 0 {
            
            let maxDayIndex = monthlyDataList.count - 1
            
            /// pass necessary data to graph view
            cell.graph.monthContent = monthlyDataList
            var powerList : [Float] = []
            for i in 0..<monthlyDataList.count {
                cell.graph.labelData.append(monthlyDataList[maxDayIndex - i].month_simple)
                powerList.append( monthlyDataList[maxDayIndex - i].monthly_power )
            }
            cell.graph.graphPoint = powerList
            
            /// Displaying the graph
            cell.graph.setNeedsDisplay()
            cell.selectionStyle = .none
            
            /// Accessibility for MonthlyComparison Graph
            cell.isAccessibilityElement = true
            cell.accessibilityLabel = "Graphic of Monthly Comparison"
            
            return cell
            
        } else {
            
            if monthlyDataList.count != 0 {
                
                let kwhPow      = monthlyDataList[indexPath.row].monthly_power
                let kwhPower    = kwhPow.toKwhString()
                let totalSpend  = monthlyDataList[indexPath.row].monthly_power * harga
                let rupiahPower = totalSpend.toRupiahString()
                
                /// displaying all the months labels
                cell2.tableImage.layer.cornerRadius = 8
                cell2.monthLabel.text               = monthlyDataList[indexPath.row].month_full
                cell2.kwhLabel.text                 = kwhPower
                cell2.rupiahLabel.text              = rupiahPower
                cell2.selectionStyle                = .none
                
                /// Accessibility for MonthTableCell
                cell2.isAccessibilityElement        = true
                cell2.accessibilityLabel            =
                    "\(cell2.monthLabel.text ?? ""), total spending is, \((totalSpend.rounded()).accRupiahFormater()), total power usage, \((kwhPow * 100).rounded()/100) kilowatt hour"
            }
            return cell2
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 260
        } else {
            return 100
        }
    }
   
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxTitlePoint = tableView.convert(CGPoint(x: titleStackView.titleLabel.bounds.minX, y: titleStackView.titleLabel.bounds.maxY), from: titleStackView.titleLabel)
        
        navigationItem.title = scrollView.contentOffset.y > maxTitlePoint.y ? "Report" : nil
        tabBarItem.title     = scrollView.contentOffset.y > maxTitlePoint.y ? "Report" : "Overview"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let totalSpend  = monthlyDataList[indexPath.row].monthly_power * harga
        let rupiahPower = totalSpend.toRupiahString()
        
        let row = indexPath.row
        let dataParam : [String : Any] = [
            "monthlyDataList" : monthlyDataList[row],
            "rupiahPower" : rupiahPower as Any
        ]
        
        performSegue(withIdentifier: "toDetail", sender: dataParam)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail" {
            if let detailVC = segue.destination as? MonthlyDataViewController {
                
                let dataPowFull             = sender as! [String : Any]
                let dataPow: MonthlyPower   = dataPowFull["monthlyDataList"] as! MonthlyPower
                let rupiahPower             = dataPowFull["rupiahPower"] as? String
                
                detailVC.monthDetail        = dataPow.month_full
                detailVC.monthDetailPow     = dataPow.monthly_power
                detailVC.monthDetailBill    = rupiahPower
                detailVC.monthBillNumber    = dataPow.monthly_power * harga
                detailVC.monthBudget        = dataPow.monthly_budget
            }
        }
    }
    
    
    func getMonthlyData(){
        
        APIRequest.fetchMonthlyEnergyData(url: Constant.GET_MONTHLY_ENERGY_LIST,showLoader: true) { response in
            
            // handle response and store it to the data model
            self.monthlyDataList = []
            for i in 0...response.count - 1 {
                if response[i].monthly_power != 0.0 && response[i].monthly_budget != 0.0 {
                    self.monthlyDataList.append(response[i])
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.removeLoadingScreen()
            }
            
        } failCompletion: { message in
            print(message)
        }
    }
    
    @objc func refresh(sender:AnyObject) {
        
        self.getMonthlyData()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func setPullToRequest(){
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.refreshControl?.attributedTitle = .none
    }
    
}
