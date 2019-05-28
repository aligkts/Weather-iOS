//
//  ForecastCell.swift
//  Weather
//
//  Created by Ali Goktas on 27.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet weak var labelItemName: UILabel!
    @IBOutlet weak var labelItemTemperature: UILabel!
    @IBOutlet weak var imgItemIcon: UIImageView!
    
    func setWeatherItem(item: ListResponse) {
        if let tempDouble = item.main?.value(forKey: "temp") as? Double {
            labelItemTemperature.text = "\(tempDouble.removeDecimal())"+"°"
        }
        if let iconCode: String = item.weather?.first?.value(forKey: "icon") as? String {
            imgItemIcon.imageFromIconCode(iconCode: iconCode)
        }
        if let dayName: String = item.dt_txt {
            labelItemName.text = dayName.toDayName()
        }
    }
    
}
