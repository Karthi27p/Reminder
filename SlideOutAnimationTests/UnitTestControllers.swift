//
//  UnitTestControllers.swift
//  SlideOutAnimationTests
//
//  Created by TRINGAPPS on 17/12/18.
//  Copyright © 2018 Tringapps. All rights reserved.
//

import XCTest
@testable import SlideOutAnimation

class UnitTestControllers: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeController() {
        guard let controller = UIStoryboard(name: "Main", bundle: Bundle(for: ViewController.self)).instantiateViewController(withIdentifier: "Home") as? ViewController else {
            return XCTFail("Could not instantiate home view controller")
        }
        controller.loadViewIfNeeded()
        XCTAssertNotNil(controller.collectionView, "Controller doesn't have collection view")
    }
    
    func testEventsViewController() {
        guard let eventViewController = UIStoryboard(name: "Main", bundle: Bundle(for: DayEventsViewController.self)).instantiateViewController(withIdentifier: "ScheduledEvents") as? DayEventsViewController else {
            return XCTFail("Could not instantiate events view controller")
        }
        eventViewController.loadViewIfNeeded()
        XCTAssertNotNil(eventViewController.tableView, "Controller doesn't have table view")
    }
    
    func testNewsViewController() {
        guard let newsViewController = UIStoryboard(name: "Main", bundle: Bundle(for: NewsViewController.self)).instantiateViewController(withIdentifier: "News") as? NewsViewController else {
            return XCTFail("Could not instantiate news view controller")
        }
        newsViewController.loadViewIfNeeded()
        XCTAssertNotNil(newsViewController.tableView, "Controller doesn't have table view")
    }
    
    func testSearchPlacesViewController() {
        guard let mapViewController = UIStoryboard(name: "Main", bundle: Bundle(for: SearchPlacesViewController.self)).instantiateViewController(withIdentifier: "Map") as? SearchPlacesViewController else {
            return XCTFail("Could not instantiate search places view controller")
        }
        mapViewController.loadViewIfNeeded()
        XCTAssertNotNil(mapViewController.mapView, "Controller doesn't have map view")
    }
    
    func testDiaryViewController() {
        guard let diaryViewController = UIStoryboard(name: "Main", bundle: Bundle(for: DiaryViewController.self)).instantiateViewController(withIdentifier: "Diary") as? DiaryViewController else {
            return XCTFail("Could not instantiate Diary view controller")
        }
        diaryViewController.loadViewIfNeeded()
        XCTAssertNotNil(diaryViewController.tableView, "Diary Controller doesn't have table view")
    }
    
    func testAddEventsViewController() {
        guard UIStoryboard(name: "Main", bundle: Bundle(for: AddEventsViewController.self)).instantiateViewController(withIdentifier: "AddEvents") is AddEventsViewController else {
            return XCTFail("Could not instantiate Add Events view controller")
        }
    }
    
    func testAppIconsViewController() {
        guard let appIconsViewController = UIStoryboard(name: "Main", bundle: Bundle(for: AppIconsViewController.self)).instantiateViewController(withIdentifier: "AppIcons") as? AppIconsViewController else {
            return XCTFail("Could not instantiate App Icons view controller")
        }
        appIconsViewController.loadViewIfNeeded()
        XCTAssertNotNil(appIconsViewController.collectionView, "App Icons Controller doesn't have collection view")
    }
    
    func testEmailReminderViewController() {
        guard UIStoryboard(name: "Main", bundle: Bundle(for: EmailReminderViewController.self)).instantiateViewController(withIdentifier: "Email") is EmailReminderViewController else {
            return XCTFail("Could not instantiate Email Reminder view controller")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
