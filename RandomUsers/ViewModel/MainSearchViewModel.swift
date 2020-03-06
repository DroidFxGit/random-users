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
    
    var isFetching = false
    var onUpdatedData: (() -> Void)?
    var onThrowError: ((Error) -> Void)?
    var randomUsers: [RandomUser] = [] {
        didSet {
            onUpdatedData?()
        }
    }
    
    init(service: RandomUserService = RandomUserServiceConcrete()) {
        self.service = service
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
                self?.randomUsers += response.results
            case .failure(let error):
                self?.onThrowError?(error)
            }
        }
    }
    
    func randomUser(at index: IndexPath) -> RandomUser? {
        return randomUsers[index.row]
    }
}
