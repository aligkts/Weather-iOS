//
//  AddLocationViewDelegate.swift
//  Weather
//
//  Created by Ali Goktas on 20.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation

protocol AddLocationViewDelegate: NSObjectProtocol {
    func favoritesFromCoreData(favoritesList: [FavoriteLocationEntity])
}
