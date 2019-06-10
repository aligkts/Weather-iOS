//
//  ForecastResponseTest.swift
//  WeatherTests
//
//  Created by Ali Goktas on 28.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import XCTest
@testable import Weather


class ForecastResponseTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitShouldTakeCity() {
        let city = City(id: 6692526, name: "Ankara")
        XCTAssertEqual(city.id, 6692526)
        XCTAssertEqual(city.name, "Ankara")
    }
    
}
