//
//  MainPresenter.swift
//  Weather
//
//  Created by Ali Goktas on 15.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation
import MapKit

class MainPresenter {
    
    weak private var mainViewDelegate: MainViewDelegate?
    var favoriteLocationList = [FavoriteLocationEntity]()
    var modelList: [WeatherResponse] = []
    var apiClient: ApiInteractor
    
    init() {
        self.apiClient = ApiInteractor()
    }
    
    func setViewDelegate(mainViewDelegate: MainViewDelegate?) {
        self.mainViewDelegate = mainViewDelegate
    }
    
    func makeApiRequest(latitude: Double, longitude: Double) {
        apiClient.getWeatherByLatLng(latitude: latitude,
                                     longitude: longitude,
                                     unitType: "Metric",
                                     language: "tr",
                                     completionHandler: { responseData in
                                        do {
                                            let weather = try JSONDecoder().decode(WeatherResponse.self, from: responseData)
                                            self.mainViewDelegate?.setCurrentUiComponents(modelResponse: weather)
                                        } catch let error {
                                            print("Json Parse Error : \(error)")
                                        }
                                    }) { error in
                                        print(error)
                                    }
    }
    
    func getResults() {
        self.favoriteLocationList = PersistentService.fetchAll
        self.modelList.removeAll()
        for favoriteLocation in favoriteLocationList {
            makeApiRequestFor(favoriteLocation: favoriteLocation)
        }
    }
    
    func makeApiRequestFor(favoriteLocation: FavoriteLocationEntity) {
        let id: String = favoriteLocation.id
        apiClient.getWeatherByLatLng(latitude: favoriteLocation.latitude,
                                     longitude: favoriteLocation.longitude,
                                     unitType: "Metric",
                                     language: "tr",
                                     completionHandler: { responseData in
                                        do {
                                            var weather = try JSONDecoder().decode(WeatherResponse.self, from: responseData)
                                            weather.uuid = id
                                            weather.favoriteLocation = favoriteLocation
                                            self.modelList.append(weather)
                                        } catch let error {
                                            print("Json Parse Error : \(error)")
                                        }
                                        if self.modelList.count == self.favoriteLocationList.count {
                                            self.mainViewDelegate?.setListToTableView(model: self.modelList)
                                        }
                                    },
                                    failureHandler: { error in
                                        print("Request Error : \(error)")
                                    })
    }

}
