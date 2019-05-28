//
//  ListResponse.swift
//  Weather
//
//  Created by Ali Goktas on 28.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation

struct ListResponse {
    
    let dt : Int?
    let main : NSDictionary?
    let weather : [NSDictionary]?
    let clouds : NSDictionary?
    let wind : NSDictionary?
    let sys : NSDictionary?
    let dt_txt : String?
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case sys = "sys"
        case dt_txt = "dt_txt"
    }
    
    init(resultModel: NSDictionary) {
        self.dt = resultModel.value(forKey: "dt") as? Int
        self.main = resultModel.value(forKey: "main") as? NSDictionary
        self.weather = resultModel.value(forKey: "weather") as? [NSDictionary]
        self.clouds = resultModel.value(forKey: "clouds") as? NSDictionary
        self.wind = resultModel.value(forKey: "wind") as? NSDictionary
        self.sys = resultModel.value(forKey: "sys") as? NSDictionary
        self.dt_txt = resultModel.value(forKey: "dt_txt") as? String
    }
    
}

