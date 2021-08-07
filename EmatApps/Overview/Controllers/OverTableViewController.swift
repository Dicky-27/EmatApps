//
//  OverTableViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit
import Charts
import CoreData

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
        chartView.xAxis.labelTextColor = UIColor(named: "Black") ?? .blue
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
    var energyModel: [Energies] = []

    var cobain: Float = 0
    
    
    var user = [User]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        
        
        self.tableView.separatorStyle = .none
        navigationItem.title = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        tableView.tableHeaderView = tableHeaderView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        titleStackView.button.addTarget(self, action: #selector(settingButton) , for: .touchUpInside)
        
        //load data from server
        loadPowerData()
        //        setData()
        
        
     //   tableView.isScrollEnabled = false
        
      
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
            
            notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
            
            
    }
    
//
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "Background")
        loadData()
        loadPowerData()
        
        if Core.shared.isNewUser() {
            //show onboarding
            let vc = storyboard?.instantiateViewController(identifier: "onboarding") as! OnboardingViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                //call any function
//            self.loadPowerData()
//            self.setData()
//            self.tableView.reloadData()
//            }
        
        
        
        tableView.reloadData()
        
    }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        loadData()
        
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
            lineChartView.frame = CGRect(x: 0, y: 0, width: cell.chartOver.frame.size.width, height: cell.chartOver.frame.size.height)
            setData()
            
            let date = Date()
            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLLL"
            let day = calendar.component(.day, from: date)
            let month = dateFormatter.string(from: date)
            
            cell.moneySave.text = "Rp. 0"
            cell.dateNow.text = "\(day) \(month)"
            
            
            return cell
            
        }else if indexPath.section == 1 {
          
            cell2.selectionStyle = .none

//            if PowerViewController.budgetCal != 0 {
//                let test = Float(PowerViewController.budgetCal / 2)
//                let coba = test / Float(PowerViewController.budgetCal)
//                cell2.progressBudget.progress = Double(CGFloat(coba))
//
//            }else {
//                cell2.progressBudget.progress = 0
//            }
//
            var kwhTot:Float = 0
            var power:Float = 0
        
            if energyModel.isEmpty == false {
                for i in 0..<energyModel.count{
    
                    power = energyModel[i].power ?? 0
                    kwhTot += power/1000
                }
            }
            
            let duit = Float(Float(kwhTot) * 1440.70)
            
            
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.currency
            formatter.locale = Locale(identifier: "id_ID")
            formatter.maximumFractionDigits = 0
            
            var numberFromField:Float = 0
            var budget:Float = 0
            if user.isEmpty == false {
                numberFromField = user[0].budget
                budget = user[0].budget
                
                cell2.rightLbl.text = formatter.string(from: numberFromField as NSNumber)
                cell2.progressBudget.progress = Float(duit / budget)
               
                //cell2.rightLbl.text =
            }
        
            return cell2
            
        }else if indexPath.section == 2 {
            
            var kwhTot:Float = 0
            var power:Float = 0
        
            if energyModel.isEmpty == false {
                
                
                
                for i in 0..<energyModel.count{
    
                    power = energyModel[i].power ?? 0
                    kwhTot += power/1000
                    
    
                }
                
                let duit = "\(Float(Float(kwhTot) * 1440.70))"
                let formatter = NumberFormatter()
                formatter.numberStyle = NumberFormatter.Style.currency
                formatter.locale = Locale(identifier: "id_ID")
                let numberFromField = (NSString(string: duit).integerValue)
                //let money = formatter.string(from: numberFromField as NSNumber)
                
                cell3.currentSpen.text = formatter.string(from: numberFromField as NSNumber)
                
            }
            
            
            
            
            return cell3
            
        }else if indexPath.section == 3{
            
            var kwhTot:Float = 0
            var power:Float = 0
        
            if energyModel.isEmpty == false {
                let endIndex = energyModel.endIndex
                
                
                for i in 0..<energyModel.count{
    
                    power = energyModel[i].power ?? 0
                    kwhTot += power/1000
    
                }
                cell4.kwhStats.text = "\(kwhTot) kWh"
                cell4.powerStats.text = "\(String(describing: energyModel[endIndex-1].power ?? 0)) Watt"
            }
            
           
            
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
                    nextVC.onCreate = {
                        self.loadData()
                    }
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
        
        var kwhTot:Float = 0
        var power:Float = 0
        var cekIndex = 1
        
        if energyModel.isEmpty == false {
            
           // for i in 0...energyModel.count {
//
//                let indexBawah = energyModel[i].created_at()// 0
//                let indexAtas = energyModel.lastIndex(of: "a")
//
          //  }
           
            
//            for i in 0...energyModel.count{
//                //let y = DailyLoader.init().daily[i].energy_july
//                let y = energyModel[i].power ?? 0
//
//
//                let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
//
//
//
//                dataEntries1.append(entry)
//
//            }
            
            
//
        //var besok = 0

            for i in stride(from: 0, through: energyModel.count, by: 1) {
                
                cekIndex += i

                if (cekIndex >= 0 && energyModel.count > cekIndex) {

                    let isoDate = energyModel[i].created_at ?? ""
                    let nextDay = energyModel[i].created_at ?? ""

                   // let dat = "2021-08-07 10:42:17.352408+0700"
                    let dateFormatter = DateFormatter()

                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZ"
                    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                    let date = dateFormatter.date(from: isoDate)
                    let dateNext = dateFormatter.date(from: nextDay)

                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss xxxx'"
                    dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 25200) as TimeZone?



                    let calendar = Calendar.current
                    let unwrap = Date()

                    let day = calendar.component(.day, from: date ?? unwrap)
                    let datAfter = calendar.component(.day, from: dateNext ?? unwrap)



                    if day == datAfter {

                        power = energyModel[i].power ?? 0
                        kwhTot += power/1000


                    }else {


                        print(kwhTot)
                        print(power)


                         let entry2 = ChartDataEntry.init(x: Double(i), y: Double(power))
                         dataEntries2.append(entry2)
                    }


                }

                
                
            }
            
              
            
            
           
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
        set2.drawCirclesEnabled = true
        
        set2.drawHorizontalHighlightIndicatorEnabled = false
        
        set2.highlightColor = UIColor(named: "AbuA") ?? .black
        set2.lineWidth = 5
        
        
        //let chartDataSet1 = LineChartDataSet(entries: dataEntries1, label: "temperature")

      //  let set3:[ChartDataSet] = [set1, set2]
        let data = LineChartData(dataSet: set2)
        data.setDrawValues(true)
        lineChartView.data = data
        
    }
    
    // FETCH Data from server
    func loadPowerData(){

        APIRequest.fetchEnergyData(url: Constant.GET_ENERGY_LIST,showLoader: true) { response in
            
         //   print(response)
            // handle response and store it to the data model
            self.energyModel = response
            DispatchQueue.main.async {
                self.setData()
                self.tableView.reloadData()
            }
            
        } failCompletion: { message in
            // display alert failure
            // dismiss loader
           print(message)
        }
    }
    
    
     func saveData() {
            do {
                try context.save()
            } catch {
                print("Error saving category \(error)")
            }
    
            tableView.reloadData()
    
        }
    
      func loadData() {
    
            let request : NSFetchRequest<User> = User.fetchRequest()
    
            do{
                user = try context.fetch(request)
            } catch {
                print("Error loading categories \(error)")
            }
    
            tableView.reloadData()
    
        }
    

    @objc func appMovedToBackground() {
       print("app enters background")
        loadPowerData()
   }

   @objc func appCameToForeground() {
       print("app enters foreground")
        loadPowerData()
   }
}


extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
