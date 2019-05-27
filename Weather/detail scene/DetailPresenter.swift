//
//  DetailPresenter.swift
//  Weather
//
//  Created by Ali Goktas on 27.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation
import MapKit

class DetailPresenter {
    
    weak private var detailViewDelegate : DetailViewDelegate?
    var favoriteLocationList = [FavoriteLocationEntity]()
    
    func setViewDelegate(detailViewDelegate:DetailViewDelegate?) {
        self.detailViewDelegate = detailViewDelegate
    }
    
    func makeForecastRequest(latitude: Double, longitude: Double) {
        guard let url = URL(string: "\(Constants.baseUrl)forecast?lat=\(latitude)&lon=\(longitude)&&APPID=\(Constants.weatherAppId)&units=Metric&lang=tr") else { return }
        TaskManager.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Response Error")
            } else {
                if let dataResponse = data,
                    let json = try? JSONSerialization.jsonObject(with: dataResponse, options: []) as? NSDictionary {
                    let forecastModel = ForecastResponse(resultModel: json)
                    self.detailViewDelegate?.setUiComponents(modelResponse: forecastModel)
                }
            }
        }
    }
    
}
