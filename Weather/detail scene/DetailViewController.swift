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
    @IBOutlet weak var detailTableView: UITableView!
    private let detailPresenter = DetailPresenter()
    var model: WeatherResponse?
    private var forecastList: [List] = []

    override func viewDidLoad() {
        self.title = "Lokasyon Detay"
        detailPresenter.setViewDelegate(detailViewDelegate: self)
        guard let clickedLatitude = self.model?.coord?.lat else {
            return
        }
        guard let clickedLongitude = self.model?.coord?.lon else {
            return
        }
        setHeader()
        detailPresenter.makeForecastRequest(latitude: clickedLatitude, longitude: clickedLongitude)
    }
    
    func setHeader() {
        guard let iconCode = self.model?.weather?.first?.icon else {
            return
        }
        imgLocationIcon.imageFromIconCode(iconCode: iconCode)
        guard let clickedTemperature = self.model?.main?.temp else {
            return
        }
        labelLocationTemperature.text = "\(clickedTemperature.removeDecimal())"+"°"
        guard let clickedName = self.model?.name else {
            return
        }
        labelLocationName.text = clickedName
        guard let humidity = self.model?.main?.humidity else {
            return
        }
        labelHumidity.text = String(humidity)
        guard let rainPossibility = self.model?.clouds?.all else {
            return
        }
        labelRainPossibility.text = String(rainPossibility)
        guard let windSpeed = self.model?.wind?.speed else {
            return
        }
        labelWind.text = "\(windSpeed.removeDecimal())"
    }
    
    func setUiComponents(listOfDays: [List]) {
        forecastList = listOfDays
        detailTableView.reloadData()
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = forecastList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as? ForecastCell else { return UITableViewCell() }
        cell.setWeatherItem(item: item)
        return cell
    }
    
}

