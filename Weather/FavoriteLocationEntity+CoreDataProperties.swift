//
//  FavoriteLocationEntity+CoreDataProperties.swift
//  Weather
//
//  Created by Ali Goktas on 20.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//
//

import Foundation
import CoreData

extension FavoriteLocationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteLocationEntity> {
        return NSFetchRequest<FavoriteLocationEntity>(entityName: "FavoriteLocationEntity")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var id: String
    
}
