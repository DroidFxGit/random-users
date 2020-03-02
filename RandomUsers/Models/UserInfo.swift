//
//  UserInfo.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 01/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation

struct UserInfo: Equatable, Hashable {
    let gender: String
    let fullName: String
    let email: String
    let phone: String
    let imageUrl: String
    let profileImageUrl: String
    let fullAddress: String
    let registeredDate: String
    
    init(_ user: RandomUser) {
        self.gender = user.gender
        self.fullName = "\(user.name.first) \(user.name.last)"
        self.email = "email: \(user.email)"
        self.phone = "phone: \(user.phone)"
        self.imageUrl = user.picture.thumbnail
        self.profileImageUrl = user.picture.medium
        self.fullAddress = """
                           \(user.location.country).
                           \(user.location.street.name) #\(user.location.street.number).
                           \(user.location.city), \(user.location.state)
                           """
        self.registeredDate = "Registered Date: \(user.registered.date)"
    }
}
