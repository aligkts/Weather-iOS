//
//  SettingsViewController.swift
//  Weather
//
//  Created by Ali Goktas on 18.06.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @objc let positionKVO = DataManager.sharedInstance

    override func viewDidLoad() {
        let selectedUnitType = UserDefaults.standard.string(forKey: "unitType") ?? Constant.metric
        if selectedUnitType == Constant.metric {
            segmentedControl.selectedSegmentIndex = 0
        } else if selectedUnitType == Constant.imperial {
            segmentedControl.selectedSegmentIndex = 1
        }
    }
    
    @IBAction func unitTypeChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(Constant.metric, forKey: "unitType")
            positionKVO.position = Constant.metric
        case 1:
            UserDefaults.standard.set(Constant.imperial, forKey: "unitType")
            positionKVO.position = Constant.imperial
        default:
            break
        }
    }
    
}
