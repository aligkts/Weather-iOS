//
//  AlertView.swift
//  Weather
//
//  Created by Ali Goktas on 13.06.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation
import UIKit

class RatingAlertView: UIView {
    
    static let instance = RatingAlertView()
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var btnSendRate: UIButton!
    @IBOutlet weak var btnCancelRate: UIButton!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var starOne: UIButton!
    @IBOutlet weak var starTwo: UIButton!
    @IBOutlet weak var starThree: UIButton!
    @IBOutlet weak var starFour: UIButton!
    @IBOutlet weak var starFive: UIButton!
    
    let filledImage = UIImage(named: "filledStar")
    let emptyImage = UIImage(named: "emptyStar")
    var rating: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("RatingAlertView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        alertView.layer.cornerRadius = 10
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        parentView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
    }
    
    func showAlert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func starOneTapped(_ sender: UIButton) {
        starOne.setImage(filledImage, for: .normal)
        starTwo.setImage(emptyImage, for: .normal)
        starThree.setImage(emptyImage, for: .normal)
        starFour.setImage(emptyImage, for: .normal)
        starFive.setImage(emptyImage, for: .normal)
        rating = 1
    }
    
    @IBAction func starTwoTapped(_ sender: UIButton) {
        starOne.setImage(filledImage, for: .normal)
        starTwo.setImage(filledImage, for: .normal)
        starThree.setImage(emptyImage, for: .normal)
        starFour.setImage(emptyImage, for: .normal)
        starFive.setImage(emptyImage, for: .normal)
        rating = 2
    }
    
    @IBAction func starThreeTapped(_ sender: UIButton) {
        starOne.setImage(filledImage, for: .normal)
        starTwo.setImage(filledImage, for: .normal)
        starThree.setImage(filledImage, for: .normal)
        starFour.setImage(emptyImage, for: .normal)
        starFive.setImage(emptyImage, for: .normal)
        rating = 3
    }
    
    @IBAction func starFourTapped(_ sender: UIButton) {
        starOne.setImage(filledImage, for: .normal)
        starTwo.setImage(filledImage, for: .normal)
        starThree.setImage(filledImage, for: .normal)
        starFour.setImage(filledImage, for: .normal)
        starFive.setImage(emptyImage, for: .normal)
        rating = 4
    }
    
    @IBAction func starFiveTapped(_ sender: UIButton) {
        starOne.setImage(filledImage, for: .normal)
        starTwo.setImage(filledImage, for: .normal)
        starThree.setImage(filledImage, for: .normal)
        starFour.setImage(filledImage, for: .normal)
        starFive.setImage(filledImage, for: .normal)
        rating = 5
    }
    
    @IBAction func sendRate(_ sender: UIButton) {
        if let selectedRate = rating {
            print("Given rate is \(selectedRate)")
            parentView.removeFromSuperview()
            UserDefaults.standard.set("RatedBefore", forKey: "ratingStatus")
        }
    }
    @IBAction func cancel(_ sender: UIButton) {
        parentView.removeFromSuperview()
    }
    
}
