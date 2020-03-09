//
//  MockManager.swift
//  RandomUsersTests
//
//  Created by Carlos Vázquez Gómez on 08/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation

extension ProcessInfo {
    static var isRunningTests: Bool { return ProcessInfo.processInfo.arguments.contains("-uiTestsEnabled") }

    static func fileNameForKey(_ name: MockResource) -> String {
        let key = name.rawValue
        // Early exit, when UI tests are not running, key is used as filename
        guard isRunningTests else { return key }

        let name = ProcessInfo.processInfo.environment[key]
        return name ?? key
    }
}

class MockManager {
    let bundle: Bundle
    lazy var requestValidUsersJSON: Data = self.dataForFile(named: .validResponse)
    
    init(bundleName: String, mainBundle: Bundle = .main) {
        if let url = mainBundle.url(forResource: bundleName, withExtension: "bundle"),
            let bundle = Bundle(url: url) {
            self.bundle = bundle
        } else {
            self.bundle = .main
        }
    }
    
    func dataForFile(named: MockResource) -> Data {
        let resource = ProcessInfo.fileNameForKey(named)
        guard let url = bundle.url(forResource: resource, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }
        return data
    }
}
