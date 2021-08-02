//
//  PowerCell.swift
//  EmatApps
//
//  Created by Dian Dinihari on 30/07/21.
//

import UIKit

class PowerCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var powerPicker: UIPickerView!
    
    var powerData: [String] = ["450 VA", "900 VA", "1300 VA", "2200 VA", "3500 VA", "3900 VA", "4400 VA", "5500 VA", "6600 VA"]
    var pickerData = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        powerPicker.delegate = self
        powerPicker.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return powerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return powerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerData = row
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var title = UILabel()
        if let view = view {
            title = view as! UILabel
        }
        title.font = UIFont.systemFont(ofSize: 16)
        title.text = powerData[row]
        title.textColor = UIColor.systemBlue
        title.textAlignment = .center
        
        return title
    }

}
