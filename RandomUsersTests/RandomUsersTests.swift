//
//  RandomUsersTests.swift
//  RandomUsersTests
//
//  Created by Carlos Vázquez Gómez on 26/02/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import XCTest
@testable import RandomUsers

class RandomUsersTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let response = RandomUserResponse.validResponse(bundle: Bundle(for: type(of: self)))
        print(response)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
