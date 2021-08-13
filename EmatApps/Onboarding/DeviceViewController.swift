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
        
        atasButton.layer.cornerRadius = 8
        bawahButton.layer.cornerRadius = 8
        
        bawahButton.layer.borderColor = UIColor(named: "Primary")?.cgColor
        bawahButton.layer.borderWidth = 2
        
    }
    
    @IBAction func newDeviceButton(_ sender: UIButton) {
    }
    
    
    @IBAction func alreadyButton(_ sender: UIButton) {
        
        let controller = storyboard?.instantiateViewController(identifier: "Power") as! PowerViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical
        present(controller, animated: true, completion: nil)
      
    }
    
}
