//
//  MVVM_DemoTests.swift
//  MVVM DemoTests
//
//  Created by Malav Soni on 14/12/19.
//  Copyright © 2019 Malav Soni. All rights reserved.
//

import XCTest
import Firebase
@testable import MVVM_Demo

class MVVM_DemoTests: XCTestCase {
 
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCountryViewModel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let country = Country.init(withName: "Test", andCapital: "Hello")
        let countryViewModel = CountryViewModel.init(withCountry: country)
        
        // Here we make sure that view model returns same value as we had in our model.
        XCTAssertTrue(country.name == countryViewModel.getName())
        
        // Here we make sure the output of getDescription methods is same as in expected format
        XCTAssertTrue(countryViewModel.getDescription() == "\(country.name), \(country.capital)")
    }
    
    func testGetCountryListAPICall() -> Void{
        // This test will make sure our API is working fine and correct country list will be displayed.
        let promise = expectation(description: "Country List Request")
        MSServiceManager.shared.getCountryList { (aryCountry, error) in
            if aryCountry.count > 0{
                XCTAssertNil(error)
                promise.fulfill()
            }else{
                XCTAssertTrue(error != nil)
            }
        }
        wait(for: [promise], timeout: 5.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
            self.testGetCountryListAPICall()
        }
    } 
}
