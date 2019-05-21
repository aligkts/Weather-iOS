//
//  AddLocationPresenter.swift
//  Weather
//
//  Created by Ali Goktas on 20.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation
import MapKit
import CoreData

class AddLocationPresenter   {
    
    weak private var addLocationViewDelegate : AddLocationViewDelegate?
    var favoriteEntity = [FavoriteLocationEntity]()

    func setViewDelegate(addLocationViewDelegate:AddLocationViewDelegate?){
        self.addLocationViewDelegate = addLocationViewDelegate
    }
    
    func addEntityToCoreData(coord: CLLocationCoordinate2D) {
        let favoriteLocationPoint = FavoriteLocationEntity(context: PersistentService.context)
        favoriteLocationPoint.latitude = coord.latitude
        favoriteLocationPoint.longitude = coord.longitude
        PersistentService.saveContext()
    }
    
    func getFavoritesFromDb() {
        let fetchRequest: NSFetchRequest<FavoriteLocationEntity> = FavoriteLocationEntity.fetchRequest()
        do {
            let entity = try PersistentService.context.fetch(fetchRequest)
            self.favoriteEntity = entity
        } catch {}
        addLocationViewDelegate?.favoritesFromCoreData(favoritesList: favoriteEntity)
    }
        
}
