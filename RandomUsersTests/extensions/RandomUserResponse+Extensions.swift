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
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.commonDateFormatter)
        let response = try? decoder.decode(RandomUserResponse.self, from: data)
        return response!
    }
}
