//
//  Helper.swift
//  EmatApps
//
//  Created by Dicky Buwono on 20/08/21.
//

import Foundation
import UIKit

protocol StoreDelegate: NSObject {
    func didPressButton(button:UIButton)
}

protocol CloseViewProtocol: AnyObject {
    func closeViewAction(sender: UIButton!)
}

class Store: UIView {

    weak var delegate:CloseViewProtocol!

    func buttonPress(button:UIButton) {
       // delegate.closeViewAction(sender: UIButton)
    }

}
