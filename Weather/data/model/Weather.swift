//
//  Weather.swift
//  Weather
//
//  Created by Ali Goktas on 28.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

struct Weather : Decodable {
    var id : Int?
    var main : String?
    var description : String?
    var icon : String?
}
