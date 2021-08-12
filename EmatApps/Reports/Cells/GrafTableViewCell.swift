//
//  GrafTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 12/08/21.
//

import UIKit

class GrafTableViewCell: UITableViewCell {

    
    @IBOutlet weak var monthsLabel: UIStackView!
    @IBOutlet weak var monthlyComparison: UILabel!
    @IBOutlet weak var graph: GraphView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
