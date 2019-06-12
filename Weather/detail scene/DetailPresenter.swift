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
    
    func setViewDelegate(detailViewDelegate: DetailViewDelegate?) {
        self.detailViewDelegate = detailViewDelegate
    }
    
//    func makeForecastRequest(latitude: Double, longitude: Double) {
//        guard let url = URL(string: "\(Constants.baseUrl)forecast?lat=\(latitude)&lon=\(longitude)&&APPID=\(Constants.weatherAppId)&units=Metric&lang=tr") else { return }
//        TaskManager.shared.dataTask(with: url, uuid: nil) { (data, _, error) in
//            if error != nil {
//                print(error?.localizedDescription ?? "Response Error")
//            } else {
//                do {
//                    if let dataResponse = data {
//                        let model = try JSONDecoder().decode(ForecastResponse.self, from: dataResponse)
//                        if let list = model.list {
//                            for index in stride(from: 1, to: list.count, by: 8) {
//                                let listModel = List(resultModel: list[index])
//                                self.listForDays.append(listModel)
//                            }
//                        }
//                    }
//                } catch let error {
//                    print("Json Parse Error : \(error)")
//                }
//            }
//            self.detailViewDelegate?.setUiComponents(listOfDays: self.listForDays)
//        }
//    }
    
}
