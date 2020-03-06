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
    private let kHeightFooter: CGFloat = 40.0
    
    var onSelectItem: ((_ user: UserInfo) -> Void)?
    var onDeleteItem: ((_ user: UserInfo) -> Void)?
    var onBeginDragging: (() -> Void)?
    var onFetchUsers: (() -> Void)?
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: kHeightFooter)
        return spinner
    }()
    
    init(tableView: UITableView,
         data: [UserInfo],
         _ onFetchUsers: (() -> Void)? = nil,
         _ onSelectItem: ((_ index: UserInfo) -> Void)? = nil) {
        self.tableView = tableView
        self.data = data
        self.onFetchUsers = onFetchUsers
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSection = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
        if indexPath.section ==  lastSection && indexPath.row == lastRow {
            tableView.tableFooterView = activityIndicator
            tableView.tableFooterView?.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.onFetchUsers?()
                tableView.tableFooterView?.isHidden = true
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        onBeginDragging?()
    }
}
