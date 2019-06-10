//
//  WeatherResponseTest.swift
//  WeatherTests
//
//  Created by Ali Goktas on 28.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherResponseTest: XCTestCase {
    
    func testInitShouldTakeCoord() {
        let coord = Coord(lon: 29.35, lat: 37.20)
        XCTAssertEqual(coord.lat, 37.20)
        XCTAssertEqual(coord.lon, 29.35)
    }
    
    func testInitShouldTakeWeather() {
        let weather = Weather(id: 800, main: "Clear", description: "açık", icon: "01d")
        XCTAssertEqual(weather.id, 800)
        XCTAssertEqual(weather.main, "Clear")
        XCTAssertEqual(weather.description, "açık")
        XCTAssertEqual(weather.icon, "01d")
    }
    
    func testInitShouldTakeMain() {
        let main = Main(temp: 30.5,
                        pressure: 1012.92,
                        humidity: 21,
                        temp_min: 30.5,
                        temp_max: 30.5,
                        sea_level: 1012.92,
                        grnd_level: 891.92)
        XCTAssertEqual(main.temp, 30.5)
        XCTAssertEqual(main.pressure, 1012.92)
        XCTAssertEqual(main.humidity, 21)
        XCTAssertEqual(main.temp_min, 30.5)
        XCTAssertEqual(main.temp_max, 30.5)
        XCTAssertEqual(main.sea_level, 1012.92)
        XCTAssertEqual(main.grnd_level, 891.92)
    }
    
    func testInitShouldTakeWind() {
        let wind = Wind(speed: 4.87, deg: 230.077)
        XCTAssertEqual(wind.speed, 4.87)
        XCTAssertEqual(wind.deg, 230.077)
    }
    
    func testInitShouldTakeClouds() {
        let clouds = Clouds(all: 0)
        XCTAssertEqual(clouds.all, 0)
    }
    
    func testInitShouldTakeSys() {
        let sys = Sys(message: 0.0045, country: "TR", sunrise: 1559011563, sunset: 1559063635)
        XCTAssertEqual(sys.message, 0.0045)
        XCTAssertEqual(sys.country, "TR")
        XCTAssertEqual(sys.sunrise, 1559011563)
        XCTAssertEqual(sys.sunset, 1559063635)
    }
    
}
