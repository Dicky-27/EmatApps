//
//  DeviceViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 30/07/21.
//

import UIKit

class DeviceViewController: UIViewController {
    @IBOutlet weak var atasButton: UIButton!
    @IBOutlet weak var bawahButton: UIButton!
    @IBOutlet weak var OnboardingLabel: UILabel!

  //Accesibility
    override func awakeFromNib() {
        super.awakeFromNib()

        atasButton.isAccessibilityElement = true
        atasButton.accessibilityHint = ""

        bawahButton.isAccessibilityElement = true
        bawahButton.accessibilityHint = ""

        OnboardingLabel.isAccessibilityElement = true
        OnboardingLabel.accessibilityHint = ""

}

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        atasButton.layer.cornerRadius = 8
        bawahButton.layer.cornerRadius = 8
        
        bawahButton.layer.borderColor = UIColor(named: "Primary")?.cgColor
        bawahButton.layer.borderWidth = 2
        
    }
}
