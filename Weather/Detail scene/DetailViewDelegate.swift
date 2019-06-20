//
//  DetailViewDelegate.swift
//  Weather
//
//  Created by Ali Goktas on 27.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation

protocol DetailViewDelegate: NSObjectProtocol {
    
    func setUiComponents(listOfDays: [List])
    
}
