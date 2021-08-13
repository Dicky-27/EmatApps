//
//  ReportViewVC.swift
//  EmatApps
//
//  Created by Dian Dinihari on 03/08/21.
//

import UIKit
import CoreData

class ReportViewVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var reportsLabel: UILabel!
    @IBOutlet weak var monthlyComparison: UILabel!
    @IBOutlet weak var monthsLabel: UIStackView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var monthsTable: UITableView!
    
    // Properties
    let loadingView        = UIView()
    let loadingSpin        = UIActivityIndicatorView()
    let loadingLabel       = UILabel()
    let refreshControl     = UIRefreshControl()
    let viewBaru           = UIView()
    let context            = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let notificationCenter = NotificationCenter.default
    let rupiahFormatter    = NumberFormatter()
    var user               = [User]()
    var isidata            : [MonthlyPower] = []
    var hargaPerKwh        : Float = 1444.70 //predefine price per kwh
    
    var monthlyDataList: [MonthlyPower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monthsTable.delegate   = self
        monthsTable.dataSource = self
        
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.refreshControl.attributedTitle = .none
        
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        viewBaru.frame = CGRect(x: 0, y: 0, width: self.monthsTable.frame.width, height: 0)
        viewBaru.backgroundColor = UIColor(named: "Background")
        monthsTable.insertSubview(viewBaru, belowSubview: self.refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        getMonthlyData()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func appMovedToBackground() {
        // print("app enters background")
        //setLoadingScreen()
        //loadData()
        //getMonthlyData()
    }
    
    @objc func appCameToForeground() {
        //  print("app enters foreground")
        //setLoadingScreen()
        //loadData()
        getMonthlyData()
    }
    
    @objc func refresh(sender:AnyObject) {
        // Updating your data here...
        //self.loadData()
        //self.monthsTable.reloadData()
        //self.refreshControl?.endRefreshing()
        getMonthlyData()
    }
    
    func setupGraphDisplay() {
        
        if monthlyDataList.count > 0 {
            let maxDayIndex = monthlyDataList.count - 1
            
            // refresh the chart
            graphView.setNeedsDisplay()
            
            // Setup date formatter for month label
            let formatter    = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("MMM")
            
            // Set up the month name labels with sorted months
            for i in 0...monthlyDataList.count-1 {
                if let label = monthsLabel.arrangedSubviews[maxDayIndex - i] as? UILabel {
                    label.text = isidata[i].month_simple
                }
            }
        }
    }
    
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
        let totalSpend  = isidata[indexPath.row].monthly_power * hargaPerKwh              //rupiahLabel calc
        let rupiahPower = rupiahFormatter.string(from: NSNumber(value: totalSpend)) //change totalspend to string
        let kwhPower    = String(isidata[indexPath.row].monthly_power)              //change kwh to string
        
        //displaying all the labels
        cell.tableImage.layer.cornerRadius    = 9
        cell.monthLabel.text                  = isidata[indexPath.row].month_full
        cell.kwhLabel.text                    = "\(kwhPower) kWh"
        cell.rupiahLabel.text                 = "Rp \(rupiahPower ?? "0")"
        cell.selectionStyle                   = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        rupiahFormatter.numberStyle           = .decimal
        rupiahFormatter.groupingSeparator     = "."
        rupiahFormatter.maximumFractionDigits = 0
        
        let totalSpend  = isidata[indexPath.row].monthly_power * hargaPerKwh        // rupiahLabel calc
        let rupiahPower = rupiahFormatter.string(from: NSNumber(value: totalSpend)) // change totalspend to string
    
        let row = indexPath.row
        let dataParam : [String : Any] = [
            "isiData" : isidata[row],
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
        
        setLoadingScreen()
        APIRequest.fetchMonthlyEnergyData(url: Constant.GET_MONTHLY_ENERGY_LIST,showLoader: true) { response in
            // handle response and store it to the data model
            self.isidata = response

            DispatchQueue.main.async {
                //showing the chart
                self.setupGraphDisplay()
                self.monthsTable.reloadData()
                self.removeLoadingScreen()
            }
            
        } failCompletion: { message in
            // display alert failure
            // dismiss loader
            print(message)
            self.removeLoadingScreen()
        }
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        
        monthsTable.reloadData()
    }
    
    func loadData() {
        let request : NSFetchRequest<User> = User.fetchRequest()
        
        do{
            user = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        
        monthsTable.reloadData()
    }
    
    // make loading view
    private func setLoadingScreen() {
        
        let view_width  = UIScreen.main.bounds.width
        let view_height = UIScreen.main.bounds.height
        
        // Set loading frame' size
        loadingView.frame           = CGRect(x: 0, y: 0, width: view_width, height: view_height)
        loadingView.center          = CGPoint(x: view_width/2, y: view_height/2)
        loadingView.backgroundColor = UIColor(named: "Background")
        
        // Sets loading label
        loadingSpin.style           = .medium
        loadingSpin.color           = UIColor(named: "AccentColor")
        loadingSpin.frame           = CGRect(x: 0, y: 0, width: 50, height: 50)
        loadingSpin.center          = CGPoint(x: view_width/2, y: view_height/2)
        
        // Sets loading indicator
        loadingLabel.textColor      = .gray
        loadingLabel.textAlignment  = .center
        loadingLabel.font           = UIFont(name: "Circular Std", size: 10)
        loadingLabel.text           = "LOADING"
        loadingLabel.frame          = CGRect(x: 0, y: 5, width: 140, height: 30)
        loadingLabel.center         = CGPoint(x: view_width/2, y: view_height/2 + 20 )
        
        loadingView.insertSubview(loadingLabel, at: 1)
        loadingView.insertSubview(loadingSpin, at: 1)
        
        view.addSubview(loadingView)
        view.isUserInteractionEnabled = false
        loadingSpin.hidesWhenStopped  = true
        loadingSpin.startAnimating()
    }
    
    // Remove the loading view from the main view
    private func removeLoadingScreen() {
        
        view.isUserInteractionEnabled = true
        loadingView.removeFromSuperview()
        loadingSpin.removeFromSuperview()
    }
}
