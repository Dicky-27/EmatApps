//
//  EstimatedViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 30/07/21.
//

import UIKit


class EstimatedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // navigationController?.navigationBar.barTintColor = UIColor(named: "White")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "White")
    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellEst", for: indexPath) as! EstCollectionViewCell
       
        cell.estDate.text = "12 Februari"
        cell.estKwh.text = "100 Kwh"
        cell.estSpen.text = "Rp 821.000"
        cell.layer.cornerRadius = 8
      
        
        return cell

    }
    
    

}


