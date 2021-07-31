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
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Next", for: .normal)
                nextBtn.isHidden = false
            } else {
                nextBtn.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.isHidden = true
        slides = [
            OnboardingSlide(title: "Intergrated With IoT", description: "Use machine learning technology integrated with IoT, we provide the best cost you should pay", image: #imageLiteral(resourceName: "Landing_1")),
            OnboardingSlide(title: "Clear Comparison Report", description: "provide a comparison report on your electricity usage since the last month", image: #imageLiteral(resourceName: "Landing_2")),
            OnboardingSlide(title: "Electric Budget Planner Made Easy", description: "plan how much electricity expenses you want to spend in a month", image: #imageLiteral(resourceName: "Landing_3"))
        ]
        
        pageControl.numberOfPages = slides.count
        
        nextBtn.layer.cornerRadius = 8
        nextBtn.layer.borderWidth = 2
        nextBtn.layer.borderColor = UIColor(named: "Primary")?.cgColor
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "Device") as! DeviceViewController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
           // Core.shared.setIsNotNewUsert()
            present(controller, animated: true, completion: nil)
           // dismiss(animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
    @IBAction func skipButton(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(identifier: "Device") as! DeviceViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
