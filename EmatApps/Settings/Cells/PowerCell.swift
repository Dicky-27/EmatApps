//
//  PowerCell.swift
//  EmatApps
//
//  Created by Dian Dinihari on 30/07/21.
//

import UIKit

class PowerCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
  
   
    
    @IBOutlet weak var powerTf: UITextField!
    
    var selectedPower: String?
    var powerData: [String] = ["450 VA", "900 VA", "1300 VA", "2200 VA", "3500 VA", "3900 VA", "4400 VA", "5500 VA", "6600 VA", "7700 VA", "10600 VA"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        createPickerView()
  //      dismissPickerView()
        
      
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
        return powerData[row] // dropdown item
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPower = powerData[row] // selected item
        powerTf.text = selectedPower
        PowerViewController.power = selectedPower ?? ""
    }
    
    func createPickerView() {
           let pickerView = UIPickerView()
           pickerView.delegate = self
           powerTf.inputView = pickerView
    }
    
    
//    func dismissPickerView() {
//       let toolBar = UIToolbar()
//       toolBar.sizeToFit()
//        let button = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(action))
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//
//       toolBar.setItems([flexibleSpace, button], animated: true)
//
//       toolBar.isUserInteractionEnabled = true
//       powerTf.inputAccessoryView = toolBar
//    }
//
//
//    @objc func action() {
//          self.endEditing(true)
//    }

    
}
