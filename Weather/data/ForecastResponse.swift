//
//  ForecastResponse.swift
//  Weather
//
//  Created by Ali Goktas on 27.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation

struct ForecastResponse {
    
    let cod : String?
    let message : Double?
    let cnt : Int?
    let list : [NSDictionary]?
    let city : NSDictionary?
    
    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }
    
    init(resultModel: NSDictionary) {
        self.cod = resultModel.value(forKey: "cod") as? String
        self.message = resultModel.value(forKey: "message") as? Double
        self.cnt = resultModel.value(forKey: "cnt") as? Int
        self.list = resultModel.value(forKey: "list") as? [NSDictionary]
        self.city = resultModel.value(forKey: "city") as? NSDictionary
    }
    
}
