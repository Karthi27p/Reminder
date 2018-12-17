//
//  SlideOutAnimationUITests.swift
//  SlideOutAnimationUITests
//
//  Created by TRINGAPPS on 17/12/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import XCTest

class SlideOutAnimationUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCollectionViewElements() {
        
        app.collectionViews.children(matching: .any).element(boundBy: 0).tap()
        sleep(2)
        app.navigationBars.buttons.element(boundBy: 1).tap()
        sleep(2)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        sleep(2)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        sleep(2)
        app.collectionViews.children(matching: .any).element(boundBy: 1).tap()
        sleep(10)
        app.swipeUp()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        sleep(2)
        app.collectionViews.children(matching: .any).element(boundBy: 2).tap()
        sleep(2)
        app.navigationBars.buttons.element(boundBy: 1).tap()
        sleep(2)
        app.searchFields.element.typeText("Chennai")
        app.searchFields.element.typeText("\n")
        sleep(3)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.collectionViews.children(matching: .any).element(boundBy: 3).tap()
        sleep(2)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        sleep(2)
        MenuLeftDoor()
    }
    
    
    func MenuLeftDoor() {
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        sleep(1)
        app.tables.staticTexts["Scheduled Events"].tap()
        sleep(1)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.tables.staticTexts["Add Events"].tap()
        sleep(1)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        sleep(1)
        app.tables.staticTexts["App Icons"].tap()
        sleep(1)
        app.collectionViews.children(matching: .any).element(boundBy: 2).tap()
        sleep(3)
        app.alerts.buttons["OK"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.tables.staticTexts["Add To Diary"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.tables.staticTexts["Email Reminders"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }

}
