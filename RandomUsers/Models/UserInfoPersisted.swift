//
//  UserInfoPersisted.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 08/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation
import RealmSwift

class UserInfoPersisted: Object {
    @objc dynamic var gender: String = ""
    @objc dynamic var fullName: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var imageUrl: String = ""
    @objc dynamic var profileImageUrl: String = ""
    @objc dynamic var fullAddress: String = ""
    @objc dynamic var registeredDate: String = ""
    
    convenience init(_ userInfo: UserInfo) {
        self.init()
        self.gender = userInfo.gender
        self.fullName = userInfo.fullName
        self.email = userInfo.email
        self.phone = userInfo.phone
        self.imageUrl = userInfo.imageUrl
        self.profileImageUrl = userInfo.profileImageUrl
        self.fullAddress = userInfo.fullAddress
        self.registeredDate = userInfo.registeredDate
    }
    
    override class func primaryKey() -> String? {
        return "email"
    }
}
