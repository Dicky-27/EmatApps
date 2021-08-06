//
//  SettingTableViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 04/08/21.
//

import UIKit
import CoreData


class SettingTableViewController: UITableViewController {
    
    var onCreate: (() -> Void)?
    var user = [User]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "White")
        saveData()
        loadData()
    }
    
    // MARK: - Table view data source
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        saveData()
    }

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
            
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.currency
            formatter.locale = Locale(identifier: "id_ID")
            formatter.maximumFractionDigits = 0
            let numberFromField = user[0].budget
            
            cell.budgetTf.text = formatter.string(from: numberFromField as NSNumber)
            cell.selectionStyle = .none
            return cell
            
        }else if indexPath.row == 1 {
            
            cell2.powerTf.text = "\(Int(user[0].power)) VA"
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
    
    func saveData() {
           do {
               try context.save()
            
//                    guard
//                        let lastVC = presentingViewController as? OverTableViewController
//                    else {
//                        return
//
//                    }
//
//            lastVC.loadData()
//            lastVC.tableView.reloadData()
            
            if let unwrapOncreate = onCreate{
                unwrapOncreate()
            }
                
                    
           } catch {
               print("Error saving category \(error)")
           }
   
          // tableView.reloadData()
        
        
   
       }
   
     func loadData() {
   
           let request : NSFetchRequest<User> = User.fetchRequest()
   
           do{
               user = try context.fetch(request)
           } catch {
               print("Error loading categories \(error)")
           }
   
          // tableView.reloadData()
   
       }

}
