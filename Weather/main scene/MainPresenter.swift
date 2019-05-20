//
//  MainPresenter.swift
//  Weather
//
//  Created by Ali Goktas on 15.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation

class MainPresenter {
    
    weak private var mainViewDelegate : MainViewDelegate?
    
    func setViewDelegate(mainViewDelegate:MainViewDelegate?){
        self.mainViewDelegate = mainViewDelegate
    }
    
    func makeApiRequest(latitude: Double, longitude: Double) {
        guard let url = URL(string: "\(Constants.baseUrl)weather?lat=\(latitude)&lon=\(longitude)&&APPID=\(Constants.weatherAppId)&units=Metric&lang=en") else { return }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var weatherArray: [WeatherResponse] = []
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Response Error")
            } else {
                if let dataResponse = data,
                    let json = try? JSONSerialization.jsonObject(with: dataResponse, options: []) as? NSDictionary {
                    let weatherModel = WeatherResponse(resultModel: json)
                    weatherArray.append(weatherModel)
                }
                DispatchQueue.main.sync {
                    self.mainViewDelegate?.setCurrentUiComponents(modelResponse: weatherArray)
                }
            }
        }.resume()
    }
    
    func downloadImageFromIconCode(iconCode: String) {
        let iconUrl = URL(string: "\(Constants.API_IMAGE_BASE_URL)\(iconCode).png")
        downloadImage(from: iconUrl!)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            //print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() {
                self.mainViewDelegate?.iconDownloadedFromIconCode(data: data)
            }
        }
    }
}
