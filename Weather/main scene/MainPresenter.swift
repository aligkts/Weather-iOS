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
    
    weak private var mainViewDelegate : MainViewDelegate?
    var favoriteLocationList = [FavoriteLocationEntity]()
    

    func setViewDelegate(mainViewDelegate:MainViewDelegate?) {
        self.mainViewDelegate = mainViewDelegate
    }
    
    func makeApiRequest(latitude: Double, longitude: Double) {
        guard let url = URL(string: "\(Constants.baseUrl)weather?lat=\(latitude)&lon=\(longitude)&&APPID=\(Constants.weatherAppId)&units=Metric&lang=tr") else { return }
        TaskManager.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Response Error")
            } else {
                do
                {
                    if let dataResponse = data {
                        let model = try JSONDecoder().decode(WeatherResponse.self, from: dataResponse)
                        self.mainViewDelegate?.setCurrentUiComponents(modelResponse: model)
                    }
                }
                catch let error{
                    print("Json Parse Error : \(error)")
                }
            }
        }
    }
    
    func getResults() {
        self.favoriteLocationList = PersistentService.fetchAll
        for index in favoriteLocationList {
            makeApiRequestForFavorites(latitude: index.latitude, longitude: index.longitude)
            //Can be better with using escaping closure
        }
    }
   
    func makeApiRequestForFavorites(latitude: Double, longitude: Double) {
        guard let url = URL(string: "\(Constants.baseUrl)weather?lat=\(latitude)&lon=\(longitude)&&APPID=\(Constants.weatherAppId)&units=Metric&lang=tr") else { return }
        TaskManager.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Response Error")
            } else {
                do
                {
                    if let dataResponse = data {
                        let model = try JSONDecoder().decode(WeatherResponse.self, from: dataResponse)
                        self.mainViewDelegate?.addModelToList(model: model)
                    }
                }
                catch let error{
                    print("Json Parse Error : \(error)")
                }
            }
        }
    }
    
}
