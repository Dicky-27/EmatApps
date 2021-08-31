//
//  UIHelper.swift
//  EmatApps
//
//  Created by Dian Dinihari on 31/08/21.
//

import Foundation
import UIKit

extension ReportTableViewController {
    
    func setLoadingScreen() {
        
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
    
    func removeLoadingScreen() {
        
        tableView.isUserInteractionEnabled = true
        loadingView.removeFromSuperview()
        spinner.removeFromSuperview()
        
    }
}
