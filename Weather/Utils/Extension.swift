//
//  Extension.swift
//  Weather
//
//  Created by Ali Goktas on 21.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//
import Foundation
import UIKit

extension UIImageView {
    public func imageFromIconCode(iconCode: String) {
        let url = "\(API.API_IMAGE_BASE_URL)\(iconCode).png"
        self.image = nil
        let urlStringNew = url.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, _, error) -> Void in
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.sync(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }
}

extension Double {
    public func removeDecimal() -> Int {
        let temperatureWithDecimals = String(self)
        let temperatureInt = (temperatureWithDecimals as NSString).integerValue
        return temperatureInt
    }
    
}

extension String {
    func toDayName() -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let inputDate = inputDateFormatter.date(from: self)
        let outputDateFormetter = DateFormatter()
        outputDateFormetter.dateFormat = "EEEE"
        if let inputDate = inputDate {
            let day = outputDateFormetter.string(from: inputDate)
            return day
        }
        return nil
    }
}

extension Int {
    public func temperatureByUnitType() -> String? {
        let type = UserDefaults.standard.string(forKey: "unitType") ?? ""
        switch type {
            case "Metric":
                return "\(self)" + "°"
            case "Imperial":
                return "\(self)" + "°F"
            default:
                break
        }
        return nil
    }
}

func checkLanguageIsTurkish() -> Bool {
    return NSLocale.preferredLanguages[0].range(of: "tr") != nil
}
