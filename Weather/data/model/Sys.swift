//
//  Sys.swift
//  Weather
//
//  Created by Ali Goktas on 28.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

struct Sys : Decodable {
    var message : Double?
    var country : String?
    var sunrise : Int?
    var sunset : Int?
}
