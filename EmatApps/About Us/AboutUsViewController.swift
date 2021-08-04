//
//  AboutUsViewController.swift
//  EmatApps
//
//  Created by Dian Dinihari on 29/07/21.
//

import UIKit

@IBDesignable
class AboutUsViewController: UIViewController {
    
  //  let label = UILabel()
    @IBOutlet weak var descLbl: UILabel!
    
    let stringValue = "Emat is an iOS app connected to IOT device that monitor, compare, and forecast electricity usage, give user reminder to save electricity and give user early warning message to prevent user from electricity bill bump."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        attributedString.setColorForText(textForAttribute: "Emat", withColor: #colorLiteral(red: 0.08218777925, green: 0.5918437839, blue: 0.8580096364, alpha: 1))
        attributedString.setColorForText(textForAttribute: "monitor", withColor: #colorLiteral(red: 0.08218777925, green: 0.5918437839, blue: 0.8580096364, alpha: 1))
        attributedString.setColorForText(textForAttribute: "compare", withColor: #colorLiteral(red: 0.08218777925, green: 0.5918437839, blue: 0.8580096364, alpha: 1))
        attributedString.setColorForText(textForAttribute: "forecast", withColor: #colorLiteral(red: 0.08218777925, green: 0.5918437839, blue: 0.8580096364, alpha: 1))
        
        descLbl.font = UIFont(name: "Poppins", size: 14)
        descLbl.attributedText = attributedString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor(named: "White")
    }
    
    @IBAction func aboutUs(_ sender: UIButton) {
    
    }
}

extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}
