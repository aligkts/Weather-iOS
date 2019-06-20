//
//  ForecastResponse.swift
//  Weather
//
//  Created by Ali Goktas on 27.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation

struct ForecastResponse: Decodable {
    
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [List]?
    let city: City?
    
    init(resultModel: ForecastResponse) {
        self.cod = resultModel.cod
        self.message = resultModel.message
        self.cnt = resultModel.cnt
        self.list = resultModel.list
        self.city = resultModel.city
    }

}
