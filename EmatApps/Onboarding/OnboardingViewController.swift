//
//  OnboardingViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 30/07/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet var holderView: UIView!
    
    let scollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    
    private func configure() {
        scollView.frame = holderView.bounds
        holderView.addSubview(scollView)
        
        let titles = ["Welcome", "Location", "All Set"]
        
        for x in 0..<3 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * (holderView.frame.size.width), y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            
            scollView.addSubview(pageView)
            
            
            // title , image, button
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width-20, height: 120))
            
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10+120+10, width: pageView.frame.size.width-20, height: pageView.frame.size.height - 60 - 130 - 15))
            
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height-60, width: pageView.frame.size.width-20, height: 50))
            
            
            label.textAlignment = .center
            label.font = UIFont(name: "Halvetica-Bold", size: 32)
            pageView.addSubview(label)
            label.text = titles[x]
            
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "Landing\(x+1)")
            
            pageView.addSubview(imageView)
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.setTitle("Continue", for: .normal)
            
            if x == 2 {
                button.setTitle("Get Started", for: .normal)
            }
            
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.tag = x+1
            pageView.addSubview(button)
        }
    
        
        scollView.contentSize = CGSize(width: holderView.frame.size.width*3, height: 0)
        scollView.isPagingEnabled = true
    }
    
    
    @objc func didTapButton(_ button: UIButton) {
        
        guard button.tag < 3 else {
            Core.shared.setIsNotNewUsert()
            dismiss(animated: true, completion: nil)
            return
        }
        
        scollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
        
        
    }

}
