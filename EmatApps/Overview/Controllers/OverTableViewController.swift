//
//  OverTableViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit
import CoreData

class OverTableViewController: UITableViewController {
    
    lazy var titleStackView: TitleStackView = {
        let titleStackView = TitleStackView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 40.0)))
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        return titleStackView
    }()
    
    lazy var tableHeaderView: UIView = {
        let tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 40.0)))
        tableHeaderView.backgroundColor = UIColor(named: "Background")
        tableHeaderView.addSubview(titleStackView)
        titleStackView.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: 16.0).isActive = true
        titleStackView.topAnchor.constraint(equalTo: tableHeaderView.topAnchor).isActive = true
        titleStackView.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: -16.0).isActive = true
        titleStackView.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor).isActive = true
        return tableHeaderView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView.separatorStyle = .none
        navigationItem.title = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        tableView.tableHeaderView = tableHeaderView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        titleStackView.button.addTarget(self, action: #selector(settingButton) , for: .touchUpInside)
        
      
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
            
        Loading.viewBaru.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 0)
        Loading.viewBaru.backgroundColor = UIColor(named: "Background")
        
        
        setTableViewBackgroundGradient(UIColor(named: "Background") ?? .blue, UIColor(named: "Wblack") ?? .black)
        setPullToRequest()
        setLoadingScreen()
        checkUserByData()
        
        titleStackView.button.isAccessibilityElement = true
        titleStackView.button.accessibilityLabel = "Setting"
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "Background")
        checkUserByData()
        
        loadData()
        loadPowerData()
        loadDailyData()
    
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        loadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Core.shared.isNewUser() {
            let sb = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "onboarding") as! OnboardingViewController
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        }
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
        let offset = scrollView.contentOffset.y

        navigationItem.title = scrollView.contentOffset.y > maxTitlePoint.y ? "Overview" : nil
        tabBarItem.title = scrollView.contentOffset.y > maxTitlePoint.y ? "Overview" : "Overview"
        setTableViewBackgroundGradient(UIColor(named: "Background") ?? .blue, UIColor(named: "Wblack") ?? .black)
        Loading.viewBaru.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: offset + titleStackView.frame.height)

     }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.contentView.backgroundColor = UIColor(named: "Background")
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = UIColor.black
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? CellOneTableViewCell else {fatalError("Cell is not of kind FormItemTableViewCell")}
        guard let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as? CellTwoTableViewCell else {fatalError("Cell is not of kind FormItemTableViewCell")}
        guard let cell3 = tableView.dequeueReusableCell(withIdentifier: "cell3") as? CellThreeTableViewCell else {fatalError("Cell is not of kind FormItemTableViewCell")}
        guard let cell4 = tableView.dequeueReusableCell(withIdentifier: "cell4") as? CellFourTableViewCell else {fatalError("Cell is not of kind FormItemTableViewCell")}
        guard let cell5 = tableView.dequeueReusableCell(withIdentifier: "cell5") as? CellFiveTableViewCell else {fatalError("Cell is not of kind FormItemTableViewCell")}
        
        setTableViewBackgroundGradient(UIColor(named: "Background") ?? .blue, UIColor(named: "Wblack") ?? .black)
        
        if indexPath.section == 0 {
        
            cell.selectionStyle = .none
            cell.setData()
            ChartSetup.drawing(view: cell.chartOver)
            
            return cell
            
        }else if indexPath.section == 1 {
          
            cell2.selectionStyle = .none
            cell2.setup()
            
            return cell2
            
        }else if indexPath.section == 2 {
            
            cell3.selectionStyle = .none
            cell3.setup()
            return cell3
            
        }else if indexPath.section == 3{
            
            cell4.setup()
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
                let date = Date()
                nextVC.date = date

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

    func loadPowerData(){
        
        APIRequest.fetchEnergyData(url: Constant.GET_ENERGY_LIST,showLoader: true) { response in
            EnergiesLoad.energyModel = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.removeLoadingScreen()
            }}
            failCompletion: { message in print(message) }
        }
    
    func loadDailyData(){
        
        APIRequest.fetchDailyEnergyData(url: Constant.GET_DAILY_ENERGY_LIST,showLoader: true) { response in
            EnergiesLoad.daily_energy = response
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.removeLoadingScreen()
            }}
            failCompletion: { message in print(message) }
        }
    
    
    func loadData() {

            let request : NSFetchRequest<User> = User.fetchRequest()

            do{
                UserData.user = try UserData.context.fetch(request)
            } catch {
                print("Error loading categories \(error)")
            }

            tableView.reloadData()

        }
    

    @objc func appMovedToBackground() {
        setLoadingScreen()
        loadPowerData()
   }

   @objc func appCameToForeground() {
        setLoadingScreen()
        loadPowerData()
   }
    
    @objc func refresh(sender:AnyObject)
    {
        self.loadPowerData()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    private func checkUserByData() {
        var isEmpty: Bool {
            do {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
                let count  = try UserData.context.count(for: request)
                return count == 0
            } catch {
                return true
            }
        }
        
        if isEmpty == true {
            UserDefaults.standard.set(false, forKey: "isNewUser")
        }else {
            UserDefaults.standard.set(true, forKey: "isNewUser")
        }
    }
    
    
    func setTableViewBackgroundGradient(_ topColor:UIColor, _ bottomColor:UIColor) {

        let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer = CAGradientLayer()
        let backgroundView = UIView(frame: tableView.bounds)
        gradientLayer.colors = gradientBackgroundColors
        gradientLayer.locations = [0.5, 0.5]
        gradientLayer.frame = tableView.bounds
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundView
    }
    
    func setPullToRequest(){
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        self.refreshControl?.attributedTitle = .none
        
        if let refresh = self.refreshControl {
            tableView.insertSubview(Loading.viewBaru, belowSubview: refresh)
        }else {
            fatalError("No refresh control")
        }
        
    }
    
    
    
    
}


