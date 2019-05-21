//
//  MainViewDelegate.swift
//  Weather
//
//  Created by Ali Goktas on 15.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation

protocol MainViewDelegate: NSObjectProtocol {
    
    func foundCurrentLocation(latitude: (Double),longitude: (Double))
    func permissionDenied()
    func setCurrentUiComponents(modelResponse: [WeatherResponse])
    func favoritesRequestResult(model: WeatherResponse)

}
