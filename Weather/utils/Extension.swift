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
        let url = "\(Constants.API_IMAGE_BASE_URL)\(iconCode).png"
        self.image = nil
        let urlStringNew = url.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.sync(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
        }).resume()
    }}

extension Double {
    public func removeDecimal() -> Int {
        let temperatureWithDecimals = String(self)
        let temperatureInt = (temperatureWithDecimals as NSString).integerValue
        return temperatureInt
    }
}

