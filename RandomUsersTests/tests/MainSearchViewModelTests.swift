//
//  MainSearchViewModelTests.swift
//  RandomUsersTests
//
//  Created by Carlos Vázquez Gómez on 09/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import XCTest
import RealmSwift
@testable import RandomUsers

class MainSearchViewModelTests: XCTestCase {
    let service = RandomUserServiceMock()
    var testRealm = RealmManager(realm: try! Realm())
    var viewModel: MainSearchViewModel!
    
    override func setUp() {
    }

    override func tearDown() {
    }

    func testThatServiceObtainedDataWhenServiceHasValidResponse() {
        let expectation = self.expectation(description: "Data was obtained successfully")
        let response = RandomUserResponse.validResponse(bundle: Bundle(for: type(of: self)))
        service.response = response

        viewModel = MainSearchViewModel(service: service, realmManager: testRealm)
        XCTAssert(viewModel.userInfo.count == 0)
        viewModel.onUpdatedData = { expectation.fulfill() }
        viewModel.fetchRandomUsers()
        
        waitForExpectations(timeout: 0.5, handler: nil)
        XCTAssert(viewModel.userInfo.count > 0)
    }
    
    func testThatResponseThrowsErrorWhenServiceFailed() {
        let expectation = self.expectation(description: "Error was thrown by the service")
        let response = RandomUserResponse.validResponse(bundle: Bundle(for: type(of: self)))
        service.response = response
        service.shouldShowError = true
        
        viewModel = MainSearchViewModel(service: service, realmManager: testRealm)
        viewModel.onThrowError = { error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        viewModel.fetchRandomUsers()
        
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testThatResponseFiltersDuplicatedUsersWhenHasSameUsers() {
        let response = RandomUserResponse.duplicatedUsersResponse(bundle: Bundle(for: type(of: self)))
        service.response = response
        
        XCTAssertEqual(response.results.count, 4)
        viewModel = MainSearchViewModel(service: service, realmManager: testRealm)
        viewModel.fetchRandomUsers()
        XCTAssertEqual(viewModel.userInfo.count, 2)
    }
}
