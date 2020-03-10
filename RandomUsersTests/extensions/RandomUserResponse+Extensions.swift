//
//  RandomUserResponse+Extensions.swift
//  RandomUsersTests
//
//  Created by Carlos Vázquez Gómez on 09/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation
@testable import RandomUsers

extension RandomUserResponse {
    static func validResponse(bundle: Bundle = .main) -> RandomUserResponse {
        let manager = MockManager(bundleName: "random_users", mainBundle: bundle)
        let data = manager.requestValidUsersJSON
        return parsed(data)
    }
    
    static func duplicatedUsersResponse(bundle: Bundle = .main) -> RandomUserResponse {
        let manager = MockManager(bundleName: "random_users", mainBundle: bundle)
        let data = manager.requestDuplicatedUsersJSON
        return parsed(data)
    }
    
    private static func parsed(_ data: Data) -> RandomUserResponse {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.commonDateFormatter)
        let response = try? decoder.decode(RandomUserResponse.self, from: data)
        return response!
    }
}
