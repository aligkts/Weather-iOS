//
//  DetailViewController.swift
//  Weather
//
//  Created by Ali Goktas on 27.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, DetailViewDelegate  {
   
    @IBOutlet weak var labelLocationName: UILabel!
    @IBOutlet weak var labelLocationTemperature: UILabel!
    @IBOutlet weak var imgLocationIcon: UIImageView!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelRainPossibility: UILabel!
    @IBOutlet weak var labelWind: UILabel!
    private let detailPresenter = DetailPresenter()
    var model: WeatherResponse?
    
    override func viewDidLoad() {
        detailPresenter.setViewDelegate(detailViewDelegate: self)
        guard let clickedLatitude = self.model?.coord?.value(forKey: "lat") as? Double else {
            return
        }
        guard let clickedLongitude = self.model?.coord?.value(forKey: "lon") as? Double else {
            return
        }
        setHeader()
        detailPresenter.makeForecastRequest(latitude: clickedLatitude, longitude: clickedLongitude)
    }
    
    func setHeader() {
        guard let iconCode = self.model?.weather?.first?.value(forKey: "icon") as? String else {
            return
        }
        imgLocationIcon.imageFromIconCode(iconCode: iconCode)
        guard let clickedTemperature = self.model?.main?.value(forKey: "temp") as? Double else {
            return
        }
        labelLocationTemperature.text = "\(clickedTemperature.removeDecimal())"+"°"
        guard let clickedName = self.model?.name else {
            return
        }
        labelLocationName.text = clickedName
        guard let humidity = self.model?.main?.value(forKey: "humidity") as? Int else {
            return
        }
        labelHumidity.text = String(humidity)
        guard let rainPossibility = self.model?.clouds?.value(forKey: "all") as? Int else {
            return
        }
        labelRainPossibility.text = String(rainPossibility)
        guard let windSpeed = self.model?.wind?.value(forKey: "speed") as? Double else {
            return
        }
        labelWind.text = "\(windSpeed.removeDecimal())"
    }
    
    func setUiComponents(modelResponse: ForecastResponse) {
        //forecast request result for clicked item
    }
    
}
