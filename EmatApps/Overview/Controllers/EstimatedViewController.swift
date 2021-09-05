//
//  EstimatedViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 30/07/21.
//

import UIKit


class EstimatedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "DWhite")
        self.tabBarController?.tabBar.isHidden = true
        loadPredictData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EnergiesLoad.predictEnergy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellEst", for: indexPath) as! EstCollectionViewCell
        
        let dateFormatter = DateFormatter()
        var harga: Float = 0
        dateFormatter.dateFormat = "LLLL"
        
        let nextMonth = Calendar.current.date(byAdding: .month, value: +1, to: Date())
        let month = dateFormatter.string(from: nextMonth ?? date)
        
        if EnergiesLoad.predictEnergy.isEmpty == false {
            
            let state = UserData.user[0].power
            cell.estDate.text = "\(EnergiesLoad.predictEnergy[indexPath.row].month_full ?? "")"
            cell.estKwh.text = EnergiesLoad.predictEnergy[indexPath.row].energy_estimated?.toKwhString()
            
            if state >= 399.0 && state <= 1000.0 {
                harga = 1352
            }else {
                harga = 1440.70
            }
            
            let duit = "\(Float(Float(EnergiesLoad.predictEnergy[indexPath.row].energy_estimated ?? 0) * harga))"
            let formatterNumber = NumberFormatter()
            formatterNumber.numberStyle = NumberFormatter.Style.currency
            formatterNumber.locale = Locale(identifier: "id_ID")
            let numberFromField = (NSString(string: duit).integerValue)
            
            cell.estSpen.text = formatterNumber.string(from: numberFromField as NSNumber)
            cell.layer.cornerRadius = 8
            
            if Float(Float(EnergiesLoad.predictEnergy[indexPath.row].energy_estimated ?? 0) * harga) > UserData.user[0].power {
                cell.separatorLine.backgroundColor = UIColor(named: "Red")
                cell.contentView.addGradientBackground2(firstColor: UIColor(named: "redFirst") ?? .blue, secondColor: UIColor(named: "redSecond") ?? .white)
            }else {
                cell.separatorLine.backgroundColor = UIColor(named: "AccWhite")
                cell.contentView.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "PrGrad") ?? .white)
                
            }
            
        }else {
            cell.estDate.text = "\(month)"
            cell.estKwh.text = "0 kWh"
            cell.estSpen.text = "Rp0"
            cell.layer.cornerRadius = 8
            
        }
        
       
        
        return cell
        
    }
    
    func loadPredictData(){
        
        APIRequest.fetchPredictEnergyData(url: Constant.GET_PREDICT_ENERGY,showLoader: true) { response in
            EnergiesLoad.predictEnergy = response
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }}
            failCompletion: { message in print(message) }
        }
  

    
}


