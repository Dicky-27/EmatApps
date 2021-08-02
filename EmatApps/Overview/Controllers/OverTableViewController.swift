//
//  OverTableViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

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
        

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let data = DataLoader.init().powers
//        print(data[0].power)
//        
//        for i in 0..<10 {
//            print(data[i].created_at)
//            print(data[i].power)
//            
//            
//        }
            
        
        
        
        

        self.tableView.separatorStyle = .none
        navigationItem.title = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        tableView.tableHeaderView = tableHeaderView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        titleStackView.button.addTarget(self, action: #selector(settingButton) , for: .touchUpInside)
                
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
            return cell
            
        }else if indexPath.section == 1 {
          
            cell2.selectionStyle = .none
            return cell2
            
        }else if indexPath.section == 2 {
           
//            let harga:Float = ((DataLoader.init().powers[0].power/1000) * 24) * 1444.70
//            let formatter = NumberFormatter()
//            formatter.locale = Locale(identifier: "id_ID")
//            formatter.maximumFractionDigits = 0
//            formatter.groupingSeparator = "."
//            formatter.numberStyle = .decimal
//            
//            let formmaterPrice = formatter.string(from: harga as NSNumber)
//            cell3.currentSpen.text = "Rp \(formmaterPrice ?? "0")"
//            cell3.selectionStyle = .none
            
            
            
            return cell3
            
        }else if indexPath.section == 3{
            
            cell4.buttonEst.addTarget(self, action: #selector(estButtonAction), for: .touchUpInside)
            cell4.selectionStyle = .none
            return cell4
            
        }else {
            
            return cell5
        }

    }

   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }else if indexPath.section == 1{
            return 75
        }else if indexPath.section == 2{
            return 170
        }else if indexPath.section == 3{
            return 50
        }else {
            return 270
        }
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEst" {
            if let nextVC = segue.destination as? EstimatedViewController {
                
            }else if segue.identifier == "goSetting" {
                if let nextVC = segue.destination as? SettingViewController {
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
