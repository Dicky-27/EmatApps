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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        atasButton.layer.cornerRadius = 8
        bawahButton.layer.cornerRadius = 8
        
        bawahButton.layer.borderColor = UIColor(named: "Primary")?.cgColor
        bawahButton.layer.borderWidth = 2
        
    }
}
