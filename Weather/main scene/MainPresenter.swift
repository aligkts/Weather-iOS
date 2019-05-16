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
        guard let url = URL( string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&&APPID=3c75e1a077769372966bc6050f85b57a&units=Metric&lang=en") else { return }
        let session = URLSession.shared
        session.dataTask(with: url) {(data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                print(data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    
}
