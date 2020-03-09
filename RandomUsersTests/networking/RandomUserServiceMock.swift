//
//  RandomUserServiceMock.swift
//  RandomUsersTests
//
//  Created by Carlos Vázquez Gómez on 09/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation
@testable import RandomUsers

final class RandomUserServiceMock: RandomUserService {
    var response: RandomUserResponse?
    var shouldShowError = false
    
    func fetchRandomUsers(size: Int, completion: @escaping completionHandler<RandomUserResponse>) {
        if shouldShowError {
            completion(.failure(error: ServiceError.unknown))
        }
        guard let response = response else {
            completion(.failure(error: ServiceError.errorParse))
            return
        }
        completion(.success(response: response))
    }
}
