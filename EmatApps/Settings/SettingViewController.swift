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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aboutUs         = tableView.dequeueReusableCell(withIdentifier: "aboutUsCell") as! SettingsCell
        let monthlyBudget   = tableView.dequeueReusableCell(withIdentifier: "monthlyBudgetCell") as! MonthlyBudgetCell
        let powerCell       = tableView.dequeueReusableCell(withIdentifier: "powerCell") as! PowerCell
        
        if indexPath.section == 0 {
            
            monthlyBudget.selectionStyle = .none
            return monthlyBudget
            
        }else if indexPath.section == 1 {
            
            powerCell.selectionStyle = .none
            return powerCell
            
        }else {
            
            return aboutUs
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            print("about us selected")
            let aboutUsSB = UIStoryboard(name: "AboutUs", bundle: nil)
            let aboutUsVC = aboutUsSB.instantiateViewController(withIdentifier: "aboutUs") as! AboutUsViewController
            aboutUsVC.modalPresentationStyle = .fullScreen
            present(aboutUsVC, animated: true, completion: nil)
        }
        
    }
}
