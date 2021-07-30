//
//  SettingViewController.swift
//  EmatApps
//
//  Created by Dian Dinihari on 29/07/21.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
       
    @IBOutlet weak var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aboutUs         = tableView.dequeueReusableCell(withIdentifier: "aboutUsCell") as! SettingsCell
        let monthlyBudget   = tableView.dequeueReusableCell(withIdentifier: "monthlyBudgetCell") as! MonthlyBudgetCell
        let powerCell       = tableView.dequeueReusableCell(withIdentifier: "powerCell") as! PowerCell
        
        if indexPath.row == 0 {
            
            return monthlyBudget
            
        }else if indexPath.row == 1 {
            
            return powerCell
            
        }else {
            
            return aboutUs
        }
        
    }
}
