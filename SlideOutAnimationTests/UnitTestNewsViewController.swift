//
//  UnitTestNewsViewController.swift
//  SlideOutAnimationTests
//
//  Created by TRINGAPPS on 17/12/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import XCTest
@testable import SlideOutAnimation

class UnitTestNewsViewController: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNewsViewController() {
        if let path = Bundle.main.path(forResource: "News_Sample", ofType: "json") {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
            XCTAssertNotNil(data, "Data is nil")
            let homeData = try? JSONSerialization.jsonObject(with:data! , options: .mutableContainers)
            XCTAssertNotNil(homeData, "Home Json is Invalid")
            guard let homeDict = homeData as? [String : Any] else {
                return
            }
            
            guard (homeDict["modules"] as? [[String : Any]]) != nil else {
               return  XCTFail("Home page doesn't have any modules")
            }
            
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
