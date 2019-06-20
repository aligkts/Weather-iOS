//
//  ListResponse.swift
//  Weather
//
//  Created by Ali Goktas on 28.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation

struct List: Decodable {
    
    let dt: Int?
    let main: Main?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let sys: Sys?
    let dt_txt: String?
    
    init(resultModel: List) {
        self.dt = resultModel.dt
        self.main = resultModel.main
        self.weather = resultModel.weather
        self.clouds = resultModel.clouds
        self.wind = resultModel.wind
        self.sys = resultModel.sys
        self.dt_txt = resultModel.dt_txt
    }
    
}
