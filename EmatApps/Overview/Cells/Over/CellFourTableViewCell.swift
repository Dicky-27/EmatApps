//
//  CellFourTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

class CellFourTableViewCell: UITableViewCell {

    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewRight: UIView!
    
    @IBOutlet weak var kwhStats: UILabel!
    @IBOutlet weak var powerStats: UILabel!
    
    
    let formatter2 = MeasurementFormatter()
    var timer = Timer()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
      
        viewLeft.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "Primary") ?? .white)
        
        viewRight.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "Primary") ?? .white)
        
        viewLeft.layer.cornerRadius = 8
        viewRight.layer.cornerRadius = 8
        
        scheduledTimerWithTimeInterval()
        kwhStats.text = "400 kWh"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func scheduledTimerWithTimeInterval(){
      
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
         
    }

    @objc func updateCounting(){
        
        let randomfloat = Int.random(in: 2000...2200)
    
       //  (x*100).rounded()/100
       // let spen2 = kwhnya * harga
       // let pr += spen2/3600

        powerStats.text = "\(randomfloat) Watt"
        
        // currentSpen.text = "Rp \(formmaterPrice ?? "0")"
    }
    
    

    
}
