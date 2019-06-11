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

    func setViewDelegate(mainViewDelegate: MainViewDelegate?) {
        self.mainViewDelegate = mainViewDelegate
    }
    
    func makeApiRequest(latitude: Double, longitude: Double) {
        guard let url = URL(string: "\(Constants.baseUrl)weather?lat=\(latitude)&lon=\(longitude)&&APPID=\(Constants.weatherAppId)&units=Metric&lang=tr") else { return }
        TaskManager.shared.dataTask(with: url, uuid: nil) { (data, _, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Response Error")
            } else {
                do {
                    if let dataResponse = data {
                        let model = try JSONDecoder().decode(WeatherResponse.self, from: dataResponse)
                        self.mainViewDelegate?.setCurrentUiComponents(modelResponse: model)
                    }
                } catch let error {
                    print("Json Parse Error : \(error)")
                }
            }
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
        guard let url = URL(string: "\(Constants.baseUrl)weather?lat=\(favoriteLocation.latitude)&lon=\(favoriteLocation.longitude)&&APPID=\(Constants.weatherAppId)&units=Metric&lang=tr") else {
                return
        }
        TaskManager.shared.dataTask(with: url, uuid: id) { (data, _, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Response Error")
            } else {
                do {
                    if let dataResponse = data {
                        var model = try JSONDecoder().decode(WeatherResponse.self, from: dataResponse)
                        model.uuid = id
                        model.favoriteLocation = favoriteLocation
                        self.modelList.append(model)
                    }
                } catch let error {
                    print("Json Parse Error : \(error)")
                }
                if self.modelList.count == self.favoriteLocationList.count {
                    self.mainViewDelegate?.setListToTableView(model: self.modelList)
                }
            }
        }
    }
    
}
