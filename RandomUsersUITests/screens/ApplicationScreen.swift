//
//  ApplicationScreen.swift
//  RandomUsersUITests
//
//  Created by Carlos Vázquez Gómez on 10/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation
import XCTest

class ApplicationScreen {
    let application: XCUIApplication
    
    required init(application: XCUIApplication) {
        self.application = application
    }
    
    var tableView: XCUIElement {
        let tableView = application.tables.firstMatch
        return tableView
    }
    
    func tapCell(at index: Int) {
        let cell = tableView.cells.allElementsBoundByIndex[index]
        cell.tap()
    }
    
    func tapBack() {
        application.navigationBars.buttons.element(boundBy: 0).tap()
    }
}
