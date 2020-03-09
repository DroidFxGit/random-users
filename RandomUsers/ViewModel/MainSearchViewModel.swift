//
//  MainSearchViewModel.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 01/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation

final class MainSearchViewModel {
    let service: RandomUserService
    let realmManager: RealmManager
    
    var isFetching = false
    var onUpdatedData: (() -> Void)?
    var onThrowError: ((Error) -> Void)?
    var userInfo: [UserInfo] = [] {
        didSet {
            onUpdatedData?()
        }
    }
    
    init(service: RandomUserService = RandomUserServiceConcrete(),
         realmManager: RealmManager = try! RealmManager()) {
        self.service = service
        self.realmManager = realmManager
    }
    
    func fetchRandomUsers(size: Int = 20) {
        if isFetching {
            return
        }
        
        isFetching = true
        service.fetchRandomUsers(size: size) { [weak self] response in
            self?.isFetching =  false
            
            switch response {
            case .success(let response):
                let userInfo = response.results.compactMap { UserInfo($0) }.filter { $0 == $0 }
                self?.userInfo += userInfo
                self?.saveUsers(userInfo)
            case .failure(let error):
                self?.onThrowError?(error)
            }
        }
    }
    
    func persistedUsers() -> [UserInfo] {
        let fetchedUsers = realmManager.resultsFromRealm()
        let users: [UserInfo] = fetchedUsers.compactMap { UserInfo($0) }
        return users
    }
    
    func saveUsers(_ users: [UserInfo]) {
        let persistedUsers: [UserInfoPersisted] = users.compactMap { UserInfoPersisted($0) }
        DispatchQueue.main.async { [weak self] in
            self?.realmManager.addObjects(persistedUsers)
        }
    }
    
    func deleteUser(user: UserInfo, index: IndexPath) {
        guard let persistedUser = realmManager.resultObject(with: user.email) else { return }
        realmManager.deleteObject(persistedUser)
        userInfo.remove(at: index.row)
    }
}
