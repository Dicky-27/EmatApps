//
//  OnboardingViewController.swift
//  EmatApps
//
//  Created by Dicky Buwono on 30/07/21.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipBttn: UIButton!
   
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == SlideData.slides.count - 1 {
                nextBtn.setTitle("Next", for: .normal)
                nextBtn.isHidden = false
                
                skipBttn.isHidden = true
            } else {
                skipBttn.isHidden = false
                nextBtn.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.isHidden = true
        skipBttn.isHidden = false
        pageControl.numberOfPages = SlideData.slides.count
        nextBtn.layer.cornerRadius = 8
        nextBtn.layer.borderWidth = 2
        nextBtn.layer.borderColor = UIColor(named: "Wacc")?.cgColor
        
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == SlideData.slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "Device") as! DeviceViewController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .coverVertical
            
            present(controller, animated: true, completion: nil)
            
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
    @IBAction func skipButton(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(identifier: "Device") as! DeviceViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical
        present(controller, animated: true, completion: nil)
    }
    
}
