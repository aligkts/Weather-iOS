//
//  PersistentService.swift
//  Weather
//
//  Created by Ali Goktas on 20.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation
import CoreData

class PersistentService {

    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func deleteItem(row: Int) {
        var bookmarkList = PersistentService.fetchAll
        let task = bookmarkList[row]
        self.context.delete(task)
        self.saveContext()
    }
    
    static func addEntityToCoreData(latitude: Double, longitude: Double) {
        let favoriteLocationPoint = FavoriteLocationEntity(context: self.context)
        favoriteLocationPoint.latitude = latitude
        favoriteLocationPoint.longitude = longitude
        self.saveContext()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    static var fetchAll: [FavoriteLocationEntity] {
        let fetchRequest: NSFetchRequest<FavoriteLocationEntity> = FavoriteLocationEntity.fetchRequest()
        var bookmarkList = [FavoriteLocationEntity]()
        do {
            bookmarkList = try PersistentService.context.fetch(fetchRequest)
        } catch {}
        return bookmarkList
    }
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
