//
//  LocationManagerTest.swift
//  WeatherTests
//
//  Created by Ali Goktas on 3.06.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Weather

class LocationManagerTest: XCTestCase {
    
    var locationHelper: LocationManager!
    var locationMgr: CLLocationManager!
    weak private var fakeDelegate : MainViewDelegate?

    override func setUp() {
        super.setUp()
        locationMgr = CLLocationManager()
        locationHelper = LocationManager()
    }

    override func tearDown() {
        locationHelper = nil
        super.tearDown()
    }
    
    func testLocationManagerIsSet() {
        XCTAssertNotNil(locationHelper.locationManager)
    }
    
    func testLocationManagerDelegateIsSet() {
        locationHelper.setViewDelegate(mainViewDelegate: self.fakeDelegate)
        XCTAssertNotNil(locationHelper.locationManager.delegate)
        XCTAssert((locationHelper.locationManager.delegate!.isKind(of: LocationManager.self)))
    }
    
    func testDidUpdateLocationCallsOnAuthorizationStatusAllowed() {
        class FakeLocationManager: CLLocationManager {

        }
        let fakeLocationManager = FakeLocationManager()
        locationHelper = LocationManager()
        locationHelper.setViewDelegate(mainViewDelegate: self.fakeDelegate)
        locationHelper.locationManager.delegate!.locationManager?(fakeLocationManager, didChangeAuthorization: .authorizedWhenInUse)
    }
    
    func testWhenStatusDenied() {
        class FakeLocationManager: CLLocationManager {
            
        }
        let fakeLocationManager = FakeLocationManager()
        locationHelper = LocationManager()
        locationHelper.setViewDelegate(mainViewDelegate: self.fakeDelegate)
        locationHelper.locationManager.delegate!.locationManager?(fakeLocationManager, didChangeAuthorization: .denied)
    }
    
}
