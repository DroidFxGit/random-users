//
//  MainSearchViewControllerUITests.swift
//  RandomUsersUITests
//
//  Created by Carlos Vázquez Gómez on 10/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import XCTest

class MainSearchViewControllerUITests: XCTestCase {

    var application = XCUIApplication()
    var mainScreen: ApplicationScreen!
    
    override func setUp() {
        continueAfterFailure = false
        application.launch()
        mainScreen = ApplicationScreen(application: application)
    }

    override func tearDown() {
    }

    func testUserDetailsFlow() {
        mainScreen.tapCell(at: 0)
        mainScreen.tapBack()
    }
}
