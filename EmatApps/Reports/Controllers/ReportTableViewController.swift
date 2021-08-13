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
    let dateFormatter   = DateFormatter()
    var harga: Float    = 1444.70 //predefine price per kwh
    
    var monthlyDataList: [MonthlyPower] = []
    
    lazy var titleStackView: TitleView = {
        
        let titleStackView = TitleView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 40.0)))
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        setLoadingScreen()
        
        tableView.separatorStyle  = .none
        tableView.backgroundColor = UIColor(named: "Wblack")
        
        navigationItem.title = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage   = UIImage()
        
        tableView.tableHeaderView = tableHeaderView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.refreshControl?.attributedTitle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setLoadingScreen()
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
        }else {
            return monthlyDataList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell") as! GrafTableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as! ListTableViewCell
        
        if indexPath.section == 0 {
            
            let maxDayIndex = monthlyDataList.count - 1
            
            // pass necessary data to graph view
            cell.graph.monthContent = monthlyDataList
            var powerList : [Float] = []
            for i in 0..<monthlyDataList.count {
                cell.graph.labelData.append(monthlyDataList[maxDayIndex - i].month_simple)
                powerList.append( monthlyDataList[maxDayIndex - i].monthly_power )
            }
            cell.graph.graphPoint = powerList
            
            // setting up UI for graph
            cell.graph.setNeedsDisplay()
            cell.graph.layer.cornerRadius   = 8
            cell.graph.layer.borderWidth    = 1
            cell.graph.layer.borderColor    = UIColor.clear.cgColor
            cell.graph.layer.masksToBounds  = true
            
            dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
            
            cell.selectionStyle = .none
            
            return cell
            
        } else {
            
            if monthlyDataList.count != 0 {
                
                let kwhPow      = monthlyDataList[indexPath.row].monthly_power
                let kwhPower    = Helper.kwhFormatter(number : kwhPow)
                let totalSpend  = monthlyDataList[indexPath.row].monthly_power * harga
                let rupiahPower = Helper.rpFormatter(number : totalSpend)
                
                // displaying all the months labels
                cell2.tableImage.layer.cornerRadius = 8
                cell2.monthLabel.text               = monthlyDataList[indexPath.row].month_full
                cell2.kwhLabel.text                 = kwhPower
                cell2.rupiahLabel.text              = rupiahPower
                cell2.selectionStyle                = .none
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
        let rupiahPower = Helper.rpFormatter(number: totalSpend)
        
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
                
                let dataPowFull            = sender as! [String : Any]
                let dataPow : MonthlyPower = dataPowFull["monthlyDataList"] as! MonthlyPower
                let rupiahPower            = dataPowFull["rupiahPower"] as? String
                
                detailVC.monthDetail       = dataPow.month_full
                detailVC.monthDetailPow    = dataPow.monthly_power
                detailVC.monthDetailBill   = rupiahPower
                detailVC.monthBudget       = dataPow.monthly_budget
            }
        }
    }
    
    private func setLoadingScreen() {
        
        let barHeight   = (navigationController?.navigationBar.frame.height)!
        let titleHeight = tableHeaderView.frame.height
        let tabHeight   = (tabBarController?.tabBar.frame.height)!
        let heighTot    = barHeight + titleHeight + tabHeight
        
        loadingView.frame           = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - barHeight - titleHeight)
        loadingView.center          = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        loadingView.backgroundColor = UIColor(named: "Wblack")
        
        loadingLabel.textColor      = .gray
        loadingLabel.textAlignment  = .center
        loadingLabel.font           = UIFont(name: "Circular Std", size: 10)
        loadingLabel.text           = "LOADING"
        loadingLabel.frame          = CGRect(x: 0, y: 5, width: 140, height: 30)
        loadingLabel.center         = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2 - heighTot + 20)
        
        spinner.style               = .medium
        spinner.color               = UIColor(named: "AccentColor")
        spinner.frame               = CGRect(x: 0, y: 0, width: 50, height: 50)
        spinner.center              = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2 - heighTot)
        
        loadingView.insertSubview(loadingLabel, at: 1)
        loadingView.insertSubview(spinner, at: 1)
        
        tableView.addSubview(loadingView)
        tableView.isUserInteractionEnabled = false
        
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
    }
    
    private func removeLoadingScreen() {
        
        tableView.isUserInteractionEnabled = true
        loadingView.removeFromSuperview()
        spinner.removeFromSuperview()
        
    }
    
    func getMonthlyData(){
        
        APIRequest.fetchMonthlyEnergyData(url: Constant.GET_MONTHLY_ENERGY_LIST,showLoader: true) { response in
            
            // handle response and store it to the data model
            self.monthlyDataList = response
            
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
    
}
