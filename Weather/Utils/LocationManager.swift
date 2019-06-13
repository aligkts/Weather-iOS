//
//  LocationManager.swift
//  Weather
//
//  Created by Ali Goktas on 15.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    weak private var mainViewDelegate: MainViewDelegate?
    
    func setViewDelegate(mainViewDelegate: MainViewDelegate?) {
        self.mainViewDelegate = mainViewDelegate
        locationManager.delegate = self
    }
    
    @objc func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus()
                == .restricted ||
                CLLocationManager.authorizationStatus()
                == .denied ||
                CLLocationManager.authorizationStatus()
                == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        } else {
            print("Lütfen lokasyon servisi veya GPS etkinleştirmenizi yapınız")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLatitude = locations[0].coordinate.latitude
        let currentLongitude = locations[0].coordinate.longitude
        self.mainViewDelegate?.foundCurrentLocation(latitude: currentLatitude, longitude: currentLongitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        mainViewDelegate?.permissionDenied()
    }
    
}
