//
//  ApiInteractor.swift
//  Weather
//
//  Created by Ali Goktas on 12.06.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation
import Alamofire

class ApiInteractor {
    
    typealias ApiCompletionHandler = (_ responseData: Data) -> Void
    typealias ApiFailureHandler = (_ error: Error) -> Void
    
    func getWeatherByLatLng(latitude: Double,
                            longitude: Double,
                            unitType: String,
                            language: String,
                            completionHandler: @escaping ApiCompletionHandler,
                            failureHandler: @escaping ApiFailureHandler) {
        AF.request(API.baseUrl + API.WEATHER,
                   parameters: ["lat": latitude, "lon": longitude, "APPID": API.weatherAppId, "units": unitType, "lang": language],
                   encoding: URLEncoding.default).responseJSON { response in
                   guard let data = response.data else { return }
                    do {
                        completionHandler(data)
                    } catch let error {
                        print(error)
                    }
        }
    }
    
}
