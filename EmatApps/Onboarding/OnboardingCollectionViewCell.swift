//
//  OnboardingCollectionViewCell.swift
//  EmatApps
//
//  Created by Dicky Buwono on 30/07/21.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideDescriptionLbl: UILabel!

      //Accesibility
        override func awakeFromNib() {
            super.awakeFromNib()

            slideImageView.isAccessibilityElement = true
            slideImageView.accessibilityHint = ""

            slideTitleLbl.isAccessibilityElement = true
            slideTitleLbl.accessibilityHint = ""

            slideDescriptionLbl.isAccessibilityElement = true
            slideDescriptionLbl.accessibilityHint = ""

  }
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }}
