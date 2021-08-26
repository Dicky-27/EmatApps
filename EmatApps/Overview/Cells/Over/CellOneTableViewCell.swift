//
//  CellOneTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

class CellOneTableViewCell: UITableViewCell {
    @IBOutlet weak var lastLeg: UIView!
    @IBOutlet weak var thisLeg: UIView!
    
    @IBOutlet weak var chartOver: UIView!
    @IBOutlet weak var dateNow: UILabel!
    @IBOutlet weak var moneySave: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thisLeg.layer.cornerRadius = thisLeg.frame.size.width/2
        lastLeg.layer.cornerRadius = thisLeg.frame.size.width/2
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupAccessbility() {
        var elemets = [UIAccessibilityElement]()
        
        let kwhElemetn = UIAccessibilityElement(accessibilityContainer: self)
        kwhElemetn.accessibilityLabel = "\(dateNow.text ?? "0"), you save \(moneySave.text ?? "0")"
        kwhElemetn.accessibilityFrameInContainerSpace = dateNow.frame.union(moneySave.frame).union(chartOver.frame)
        elemets.append(kwhElemetn)
        
        self.accessibilityElements = elemets
    }
    
    func setup() {
        let calendar = Calendar.current
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let day = calendar.component(.day, from: date)
        let month = dateFormatter.string(from: date)
        
        moneySave.text = "Rp0"
        dateNow.text = "\(day) \(month)"
        
        setupAccessbility()
        
    }
}
