//
//  RandomUserService.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 01/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation

protocol RandomUserService: AnyObject {
    func fetchRandomUsers(size: Int, completion: @escaping completionHandler<RandomUserResponse>)
}
