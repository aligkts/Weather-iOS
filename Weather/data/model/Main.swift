//
//  Main.swift
//  Weather
//
//  Created by Ali Goktas on 28.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

struct Main : Decodable {
    var temp : Double?
    var pressure : Double?
    var humidity : Int
    var temp_min : Double?
    var temp_max : Double?
    var sea_level : Double?
    var grnd_level : Double?
}
