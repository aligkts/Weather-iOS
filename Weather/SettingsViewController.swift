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
    
    override func viewDidLoad() {
        let selectedUnitType = UserDefaults.standard.string(forKey: "unitType") ?? ""
        if selectedUnitType == "MetrirefreshUnitTypec" {
            segmentedControl.selectedSegmentIndex = 0
        } else if selectedUnitType == "Imperial" {
            segmentedControl.selectedSegmentIndex = 1
        }
    }
    
    @IBAction func unitTypeChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set("Metric", forKey: "unitType")
        case 1:
            UserDefaults.standard.set("Imperial", forKey: "unitType")
        default:
            break
        }
    }
    
}
