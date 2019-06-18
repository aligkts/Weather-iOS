//
//  DetailPresenter.swift
//  Weather
//
//  Created by Ali Goktas on 27.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation

class DetailPresenter {
    
    weak private var detailViewDelegate: DetailViewDelegate?
    private var listForDays: [List] = []
    var apiClient: ApiInteractor
    
    init() {
        self.apiClient = ApiInteractor()
    }
    
    func setViewDelegate(detailViewDelegate: DetailViewDelegate?) {
        self.detailViewDelegate = detailViewDelegate
    }
    
    func makeForecastRequest(latitude: Double, longitude: Double) {
        apiClient.getForecastByLatLng(latitude: latitude,
                                     longitude: longitude,
                                     unitType: "Metric",
                                     language: API.deviceLanguage,
                                     completionHandler: { responseData in
                                        do {
                                            let forecast = try JSONDecoder().decode(ForecastResponse.self, from: responseData)
                                            if let list = forecast.list {
                                                for index in stride(from: 1, to: list.count, by: 8) {
                                                    let listModel = List(resultModel: list[index])
                                                    self.listForDays.append(listModel)
                                                }
                                            }
                                        } catch let error {
                                            print("Json Parse Error : \(error)")
                                        }
                                        self.detailViewDelegate?.setUiComponents(listOfDays: self.listForDays)
                                    },
                                    failureHandler: { error in
                                        print("Forecast Request Error : \(error)")
                                    })

    }
    
}
