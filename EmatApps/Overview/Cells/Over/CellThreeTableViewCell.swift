//
//  CellThreeTableViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 29/07/21.
//

import UIKit

class CellThreeTableViewCell: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var dateNow: UILabel!
    @IBOutlet weak var kwhNumber: UILabel!
    @IBOutlet weak var currentSpen: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addGradientBackground(firstColor: UIColor(named: "Background") ?? .blue, secondColor: UIColor(named: "White") ?? .white)
       
        viewBg.addGradientBackground2(firstColor: UIColor(named: "PrimaryGrad") ?? .blue, secondColor: UIColor(named: "Primary") ?? .white)
    
        viewBg.layer.cornerRadius = 8
        
        
        let date = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: date)
        dateNow.text = "\(calendar.component(.day, from: date)) \(nameOfMonth)"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIView{
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations = [0.5, 0.5]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
       
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addGradientBackground2(firstColor: UIColor, secondColor: UIColor){
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
       // gradientLayer.locations = [0.5, 0.5]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
       
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
