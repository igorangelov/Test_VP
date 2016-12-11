//
//  VPTests.swift
//  VPTests
//
//  Created by Igor Angelov on 09/12/2016.
//  Copyright © 2016 Igor Angelov. All rights reserved.
//

import XCTest
@testable import VP

class VPTests: XCTestCase {
    
    var weatherVM : WeatherViewModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        weatherVM = WeatherViewModel.init(dictionary:   [  
            "main": [
            "temp": 9.17,
            "temp_min": 8.2,
            "temp_max": 9.17,
            "pressure": 1028.29,
            "sea_level": 1039.98,
            "grnd_level": 1028.29,
            "humidity": 96,
            "temp_kf": 0.97
            ],
            "weather": [
            [
            "id": 500,
            "main": "Rain",
            "description": "light rain",
            "icon": "10d"
            ]
            ],
            "clouds": [
            "all": 92
            ],
            "wind": [
            "speed": 2.26,
            "deg": 302.502
            ],
            "rain": [
            "3h": 0.115
            ],
            "sys": [
            "pod": "d"
            ],
            "dt_txt": "2016-12-11 15:00:00"])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testWeatherModelView()  {
        //note : assuming unit setting aren't metric but imperial
        XCTAssert(weatherVM.temperaturTitle == "9.17°F")
        XCTAssert(weatherVM.descriptionTitle == "light rain".capitalized)
        XCTAssert(weatherVM.imageUrl == "http://openweathermap.org/img/w/10d.png")
    }
    
}
