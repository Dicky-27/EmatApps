//
//  EstimatedViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 30/07/21.
//

import UIKit


class EstimatedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "DWhite")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellEst", for: indexPath) as! EstCollectionViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        
        let nextMonth = Calendar.current.date(byAdding: .month, value: +1, to: Date())
        let month = dateFormatter.string(from: nextMonth ?? date)
        
        cell.estDate.text = "\(month)"
        cell.estKwh.text = "138,8 kWh"
        cell.estSpen.text = "Rp200.000"
        cell.layer.cornerRadius = 8
        
        return cell
        
    }
    
}


