//
//  PermissionDeniedViewController.swift
//  Weather
//
//  Created by Ali Goktas on 16.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation
import UIKit

class PermissionDeniedViewController: UIViewController {
    
    @IBOutlet weak var labelWarning: UILabel!
    @IBOutlet weak var btnSettings: UIButton!
    
    @IBAction func goSettingsForPermission(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    
}
