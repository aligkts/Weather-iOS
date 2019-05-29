//
//  ExtensionTest.swift
//  WeatherTests
//
//  Created by Ali Goktas on 28.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import XCTest
@testable import Weather

class ExtensionTest: XCTestCase {

    func testRemoveDecimal() {
        let temp = 17.39
        XCTAssertEqual(temp.removeDecimal(), 17)
    }
    
    func testDateToDayName() {
        let dateString = "2019-05-28 15:00:00"
        XCTAssertEqual(dateString.toDayName(), "Salı")
    }
    
}
