//
//  RandomUserServiceConcrete.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 01/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation

final class RandomUserServiceConcrete: BaseService<RandomUserResponse>, RandomUserService {
    private let mainPath = "https://randomuser.me/api/"
    
    func fetchRandomUsers(size: Int, completion: @escaping completionHandler<RandomUserResponse>) {
        guard var components = URLComponents(string: mainPath) else {
            completion(.failure(error: ServiceError.badrequest))
            return
        }
        
        components.queryItems = [
            URLQueryItem(name: "results", value: String(size))
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = HttpMethod.get.rawValue
        perform(request: request, completion: completion)
    }
}
