//
//  RealmManager.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 08/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import UIKit
import RealmSwift

final class RealmManager {
    private let realm: Realm
    
    public convenience init() throws {
        try self.init(realm: Realm())
    }
    
    internal init(realm: Realm) {
        self.realm = realm
    }
    
    func resultsFromRealm() -> Results<UserInfoPersisted> {
        return realm.objects(UserInfoPersisted.self)
    }
    
    func resultObject(with key: String) -> UserInfoPersisted? {
        return realm.object(ofType: UserInfoPersisted.self, forPrimaryKey: key)
    }
    
    func addObjects(_ objects: [UserInfoPersisted]) {
        try! realm.write {
            realm.add(objects, update: .all)
        }
    }
    
    func deleteObject(_ object: UserInfoPersisted) {
        try! realm.write {
            realm.delete(object)
        }
    }
}
