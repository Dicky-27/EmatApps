//
//  TitleView.swift
//  EmatApps
//
//  Created by Dicky Buwono on 12/08/21.
//

import Foundation
import UIKit

class TitleView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        axis = .horizontal
        alignment = .center
        addArrangedSubview(titleLabel)
        }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Circular Std", size: 32)
        
        label.text = "Report"
        label.textColor = UIColor(named: "AccentColor")
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}
