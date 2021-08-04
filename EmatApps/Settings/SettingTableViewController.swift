//
//  SettingTableViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 04/08/21.
//

import UIKit

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        tableView.tableFooterView = UIView()
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "White")
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! MonthlyBudgetCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as! PowerCell
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "cell3") as! SettingsCell

        // Configure the cell...
        
        if indexPath.row == 0 {
            
            cell.budgetTf.text = PowerViewController.budget
            cell.selectionStyle = .none
            return cell
            
        }else if indexPath.row == 1 {
            
            cell2.powerTf.text = PowerViewController.power
            cell2.selectionStyle = .none
            return cell2
            
        }else {
            
            cell3.accessoryType = .disclosureIndicator
            return cell3
        }

        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row == 2 {
            if let viewController = UIStoryboard(name: "AboutUs", bundle: nil).instantiateViewController(withIdentifier: "aboutUs") as? AboutUsViewController {
                    if let navigator = navigationController {
                        navigator.pushViewController(viewController, animated: true)
                    }
                }
        }
    }

}
