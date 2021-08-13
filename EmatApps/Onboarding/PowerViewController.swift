//
//  PowerViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 31/07/21.
//

import UIKit

class PowerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var selectedPower: String?
    var powerData: [String] = ["450 VA", "900 VA", "1300 VA", "2200 VA", "3500 VA", "3900 VA", "4400 VA", "5500 VA", "6600 VA"]
    var currentString = ""
    
    @IBOutlet weak var powerTf: UITextField!
    @IBOutlet weak var targetTf: UITextField!
    @IBOutlet weak var stratButton: UIButton!
    
    static var budget = "Rp0"
    static var power = "0 VA"
    
    static var budgetCal = 0
    
    static var pow: Float = 0
    
    var user = [User]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stratButton.layer.cornerRadius = 8
        stratButton.layer.borderWidth = 2
        stratButton.layer.borderColor = UIColor(named: "Primary")?.cgColor
        createPickerView()
        targetTf.addBottomBorder()
        
        self.targetTf.delegate = self
        self.hideKeyboardWhenTappedAround()
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        newUser()
        
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
        
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: selectedPower?.westernArabicNumeralsOnly ?? "")
        let numberFloatValue = number?.floatValue
        
        user[0].power = numberFloatValue ?? 0
        saveData()
    }
    
    func createPickerView() {
           let pickerView = UIPickerView()
           pickerView.delegate = self
           powerTf.inputView = pickerView
    }
    
    @objc func action() {
          view.endEditing(true)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            currentString += string
            formatCurrency(string: currentString)
                
        default:
            let array = Array(string)
            var currentStringArray = Array(currentString)
            if array.count == 0 && currentStringArray.count != 0 {
                currentStringArray.removeLast()
                currentString = ""
                for character in currentStringArray {
                    currentString += String(character)
                }
                formatCurrency(string: currentString)
            }
        }
        return false
        
    }

        func formatCurrency(string: String) {
            let formatter = NumberFormatter()
            formatter.numberStyle = NumberFormatter.Style.currency
            formatter.locale = Locale(identifier: "id_ID")
            let numberFromField = (NSString(string: currentString).integerValue)
            targetTf.text = formatter.string(from: numberFromField as NSNumber)

            PowerViewController.budget = formatter.string(from: numberFromField as NSNumber) ?? ""
            PowerViewController.budgetCal = numberFromField
            
            user[0].budget = Float(numberFromField)
            saveData()
            
        }

    @IBAction func getStartedButton(_ sender: UIButton) {
        
        if powerTf.text == "" || targetTf.text == "" {
                // either textfield 1 or 2's text is empty
            let alert = UIAlertController(title: "Oops", message: "Please fill out your power and monthly budget.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            Core.shared.setIsNotNewUsert()
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func newUser() {
        let newUser = User(context: self.context)
        
        self.user.append(newUser)
        self.saveData()
        
    }
    
    func saveData() {
           do {
               try context.save()
           } catch {
               print("Error saving category \(error)")
           }
        
    }
}

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height -  1, width: self.frame.size.width - 20, height: 0.5)
        bottomLine.backgroundColor = UIColor(named: "Black")?.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
