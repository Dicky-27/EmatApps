//
//  onboardingSlide.swift
//  EmatApps
//
//  Created by Dicky Buwono on 30/07/21.
//

import Foundation
import UIKit

struct OnboardingSlide {
    let title: String
    let description: String
    let image: UIImage
}

struct SlideData {
    
   static var slides: [OnboardingSlide] = [
        OnboardingSlide(title: "Intergrated With IoT", description: "Use machine learning technology integrated with IoT, we provide the best cost you should pay", image: #imageLiteral(resourceName: "Landing_1")),
                                     
        OnboardingSlide(title: "Clear Comparison Report", description: "Provide a comparison report on your electricity usage since the last month", image: #imageLiteral(resourceName: "Landing_2")),
                                    
        OnboardingSlide(title: "Electric Budget Planner Made Easy", description: "Plan how much electricity expenses you want to spend in a month", image: #imageLiteral(resourceName: "Landing_3"))]
    
}
