//
//  MainPresenter.swift
//  Weather
//
//  Created by Ali Goktas on 15.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation
import CoreData
import MapKit

class MainPresenter {
    
    weak private var mainViewDelegate : MainViewDelegate?
    var favoriteEntity = [FavoriteLocationEntity]()

    func setViewDelegate(mainViewDelegate:MainViewDelegate?){
        self.mainViewDelegate = mainViewDelegate
    }
    
    func makeApiRequest(latitude: Double, longitude: Double) {
        guard let url = URL(string: "\(Constants.baseUrl)weather?lat=\(latitude)&lon=\(longitude)&&APPID=\(Constants.weatherAppId)&units=Metric&lang=tr") else { return }
        var weatherArray: [WeatherResponse] = []
        TaskManager.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Response Error")
            } else {
                if let dataResponse = data,
                let json = try? JSONSerialization.jsonObject(with: dataResponse, options: []) as? NSDictionary {
                let weatherModel = WeatherResponse(resultModel: json)
                    weatherArray.append(weatherModel)
                }
                self.mainViewDelegate?.setCurrentUiComponents(modelResponse: weatherArray)
            }
        }
    }
    
    func getFavoritesFromCoreData() {
        let fetchRequest: NSFetchRequest<FavoriteLocationEntity> = FavoriteLocationEntity.fetchRequest()
        do {
            let entity = try PersistentService.context.fetch(fetchRequest)
            self.favoriteEntity = entity
        } catch {}
        for i in favoriteEntity {
            makeApiRequestForFavorites(latitude: i.longitude, longitude: i.longitude)
        }
    }
    
    func makeApiRequestForFavorites(latitude: Double, longitude: Double) {
        guard let url = URL(string: "\(Constants.baseUrl)weather?lat=\(latitude)&lon=\(longitude)&&APPID=\(Constants.weatherAppId)&units=Metric&lang=tr") else { return }
        TaskManager.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Response Error")
            } else {
                if let dataResponse = data,
                    let json = try? JSONSerialization.jsonObject(with: dataResponse, options: []) as? NSDictionary {
                    let weatherModel = WeatherResponse(resultModel: json)
                    self.mainViewDelegate?.favoritesRequestResult(model: weatherModel)
                }
                
            }
        }
    }
    
}
