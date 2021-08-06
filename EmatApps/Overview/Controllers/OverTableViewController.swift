//
//  OverTableViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit
import Charts

class OverTableViewController: UITableViewController {
    
    
    
    lazy var titleStackView: TitleStackView = {
                let titleStackView = TitleStackView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 44.0)))
                titleStackView.translatesAutoresizingMaskIntoConstraints = false
                return titleStackView
            }()
    
            lazy var tableHeaderView: UIView = {
                let tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 44.0)))
                tableHeaderView.addSubview(titleStackView)
                titleStackView.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: 16.0).isActive = true
                titleStackView.topAnchor.constraint(equalTo: tableHeaderView.topAnchor).isActive = true
                titleStackView.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: -16.0).isActive = true
                titleStackView.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor).isActive = true
                
                return tableHeaderView
            }()
    
 
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        let yAxis = chartView.leftAxis
        
        chartView.noDataTextColor = .black
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.legend.enabled = false
        
        
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(3, force: false)
        yAxis.axisMinLabels = 0
        yAxis.axisMinimum = 0
        yAxis.labelTextColor = .black
        yAxis.axisLineColor = .black
        yAxis.labelPosition = .outsideChart
        yAxis.labelAlignment = .center
        yAxis.gridColor = .black
        
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .black
        chartView.xAxis.axisLineColor = UIColor.systemGray
        chartView.xAxis.gridColor = UIColor(named: "Grey") ?? .black
        
        chartView.xAxis.axisMinLabels = 1
        chartView.xAxis.axisMaxLabels = 30
        chartView.xAxis.axisMinimum = 0
        chartView.xAxis.axisMaximum = 30
        
//        let marker = CircleMarker(color: .red)
//        chartView.marker = marker
        
       // chartView.animate(xAxisDuration: 2.0)
   
        
        let marker = PillMarker(color: .white, font: UIFont.boldSystemFont(ofSize: 14), textColor: .black)
      
        chartView.marker = marker
        
        
        
        
        return chartView
    }()
        
    
    
    
    var dataEntries1 = [ChartDataEntry]()
    var dataEntries2 = [ChartDataEntry]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        
        
        self.tableView.separatorStyle = .none
        navigationItem.title = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        tableView.tableHeaderView = tableHeaderView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        titleStackView.button.addTarget(self, action: #selector(settingButton) , for: .touchUpInside)
        
        
     //   tableView.isScrollEnabled = false
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "Background")
        
        if Core.shared.isNewUser() {
            //show onboarding
            let vc = storyboard?.instantiateViewController(identifier: "onboarding") as! OnboardingViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        }
        
        tableView.reloadData()
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxTitlePoint = tableView.convert(CGPoint(x: titleStackView.titleLabel.bounds.minX, y: titleStackView.titleLabel.bounds.maxY), from: titleStackView.titleLabel)

        navigationItem.title = scrollView.contentOffset.y > maxTitlePoint.y ? "Emat" : nil
        tabBarItem.title = scrollView.contentOffset.y > maxTitlePoint.y ? "Overview" : "Overview"

     }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor(named: "Background")
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! CellOneTableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as! CellTwoTableViewCell
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "cell3") as! CellThreeTableViewCell
        let cell4 = tableView.dequeueReusableCell(withIdentifier: "cell4") as! CellFourTableViewCell
        let cell5 = tableView.dequeueReusableCell(withIdentifier: "cell5") as! CellFiveTableViewCell
        

        if indexPath.section == 0 {
        
            cell.selectionStyle = .none
            cell.chartOver.insertSubview(lineChartView, at: 0)
            lineChartView.frame = CGRect(x: 0, y: 0, width: cell.chartOver.frame.size.width - 30, height: cell.chartOver.frame.size.height - 30)
            
            
            
            return cell
            
        }else if indexPath.section == 1 {
          
            cell2.selectionStyle = .none
            
            if PowerViewController.budgetCal != 0 {
                let test = Float(PowerViewController.budgetCal / 2)
                let coba = test / Float(PowerViewController.budgetCal)
                cell2.progressBudget.progress = CGFloat(coba)
                
            }else {
                cell2.progressBudget.progress = 0
            }
           
            cell2.rightLbl.text = PowerViewController.budget
            return cell2
            
        }else if indexPath.section == 2 {
            
//            cell3.kwhNumber.text = "0"
//            cell3.currentSpen.text = "0"
//            
            var kwhTot = 0
            for i in 1...16{

                let y2 = DailyLoader.init().daily[i].energy_agus
                kwhTot += Int(y2)
            
            }
            let duit = "\(Float(Float(kwhTot) * 1440.70))"
            
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.currency
            formatter.locale = Locale(identifier: "id_ID")
            let numberFromField = (NSString(string: duit).integerValue)
            //let money = formatter.string(from: numberFromField as NSNumber)
            
            cell3.currentSpen.text = formatter.string(from: numberFromField as NSNumber)

            
            return cell3
            
        }else if indexPath.section == 3{
            
            var kwhTot = 0
            for i in 1...16{

                let y2 = DailyLoader.init().daily[i].energy_agus
                kwhTot += Int(y2)
            
            }
            
            cell4.kwhStats.text = "\(kwhTot) kWh"
            cell4.selectionStyle = .none
            return cell4
            
        }else {
           
            
            
            cell5.buttonEst.addTarget(self, action: #selector(estButtonAction), for: .touchUpInside)
            
            cell5.selectionStyle = .none
            return cell5
        }

    }

   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 260
        }else if indexPath.section == 1{
            return 70
        }else if indexPath.section == 2{
            return 110
        }else if indexPath.section == 3{
            return 120
        }else {
            return 70
        }
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEst" {
            if let nextVC = segue.destination as? EstimatedViewController {
                
            }else if segue.identifier == "goSetting" {
                if let nextVC = segue.destination as? SettingTableViewController {
                }
            }
        }
    }
    
    
    @objc func estButtonAction() {
        performSegue(withIdentifier: "goEst", sender: nil)
    }
    
    @objc func settingButton() {
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    
    func setData() {
        
        
        for i in 1...31 {
            let y = DailyLoader.init().daily[i].energy_july
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries1.append(entry)
            
        }
        
        for i in 1...16{

            let y2 = DailyLoader.init().daily[i].energy_agus
            let entry2 = ChartDataEntry.init(x: Double(i), y: Double(y2))
            dataEntries2.append(entry2)

        
        }
        
       
        
        let set1 = LineChartDataSet(entries: dataEntries1)
        let set2 = LineChartDataSet(entries: dataEntries2)

        
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 5
        set1.setColor(UIColor(named: "Primary") ?? .black)
        
        set1.highlightColor = UIColor(named: "AbuA") ?? .black
        set1.drawHorizontalHighlightIndicatorEnabled = false
        
        set2.mode = .cubicBezier
        set2.setColor(UIColor(named: "Accent") ?? .black)
        set2.drawCirclesEnabled = false
        
        set2.drawHorizontalHighlightIndicatorEnabled = false
        
        set2.highlightColor = UIColor(named: "AbuA") ?? .black
        set2.lineWidth = 5
        
        
            //let chartDataSet1 = LineChartDataSet(entries: dataEntries1, label: "temperature")

        let set3:[ChartDataSet] = [set1, set2]
        let data = LineChartData(dataSets: set3)
        data.setDrawValues(false)
        lineChartView.data = data
        
    }
    

}


class Core {
    static let shared = Core()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUsert() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

