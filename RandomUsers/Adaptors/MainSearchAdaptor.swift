//
//  MainSearchAdaptor.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 26/02/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation
import UIKit

final class MainSearchAdaptor: NSObject, UITableViewDelegate, UITableViewDataSource {
    private let tableView: UITableView!
    private let data: [UserInfo]!
    private let kHeightRow: CGFloat = 100.0
    
    var onSelectItem: ((_ user: UserInfo) -> Void)?
    var onDeleteItem: ((_ user: UserInfo) -> Void)?
    
    init(tableView: UITableView,
         data: [UserInfo],
         onSelectItem: ((_ index: UserInfo) -> Void)? = nil) {
        self.tableView = tableView
        self.data = data
        self.onSelectItem = onSelectItem
        
        super.init()
        setupAdaptor()
    }
    
    func setupAdaptor() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil),
                           forCellReuseIdentifier: UserTableViewCell.userCellIdentifier)
        tableView.rowHeight = kHeightRow
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.userCellIdentifier) as? UserTableViewCell else {
            preconditionFailure("cannot dequeue cell for \(UserTableViewCell.self)")
        }
        let user = data[indexPath.row]
        cell.configure(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = data[indexPath.row]
        onSelectItem?(user)
    }
}
