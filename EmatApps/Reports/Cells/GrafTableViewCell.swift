//
//  GrafTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 12/08/21.
//

import UIKit

class GrafTableViewCell: UITableViewCell {
    
    @IBOutlet weak var monthlyComparison: UILabel!
    @IBOutlet weak var graph: GraphView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        graph.layer.cornerRadius   = 8
        graph.layer.borderWidth    = 1
        graph.layer.borderColor    = UIColor.clear.cgColor
        graph.layer.masksToBounds  = true
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
