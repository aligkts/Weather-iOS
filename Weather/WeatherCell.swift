//
//  WeatherCell.swift
//  Weather
//
//  Created by Ali Goktas on 21.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var txtItemName: UILabel!
    @IBOutlet weak var txtItemTemperature: UILabel!
    @IBOutlet weak var imgItemIcon: UIImageView!
 
    func setWeatherItem(item: WeatherResponse) {
        txtItemName.text = item.name
        if let tempDouble = item.main?.temp {
            let selectedUnitType = UserDefaults.standard.string(forKey: "unitType") ?? Constant.metric
            if selectedUnitType == Constant.metric {
                self.txtItemTemperature.text = "\(tempDouble.removeDecimal())" + "°"
            } else if selectedUnitType == Constant.imperial {
                self.txtItemTemperature.text = tempDouble.removeDecimal().temperatureToFahrenheit()
            }
            if let iconCode: String = item.weather?.first?.icon {
                imgItemIcon.imageFromIconCode(iconCode: iconCode)
            }
        }
    }

}
