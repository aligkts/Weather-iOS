//
//  DataManager.swift
//  Weather
//
//  Created by Ali Goktas on 19.06.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation

class DataManager: NSObject {
    
    class var sharedInstance : DataManager {
        
        struct Static {
            static let instance : DataManager = DataManager()
        }
        return Static.instance
        
    }
    
    @objc dynamic var position: String
    
    private override init() {
        position = UserDefaults.standard.string(forKey: "unitType") ?? Constant.metric
    }
    
}
