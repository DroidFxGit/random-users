//
//  UserDetailViewController.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 03/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import UIKit

enum detailSection {
    case phone
    case gender
    case registered
    case address
}

class UserDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let kCellIdentifier = "detailCellIdentifier"
    private let sections: [detailSection] = [.phone, .gender, .registered, .address]

    var user: UserInfo!
    lazy var headerView: MainHeaderView = {
        let model = MainHeaderModel(name: user.fullName,
                                    email: user.email,
                                    profileURL: user.profileImageUrl)
        let header = MainHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 260.0))
        header.configure(model: model)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
    }
}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) else {
            preconditionFailure("cannot dequeue cell with \(kCellIdentifier)")
        }
        let section = sections[indexPath.section]
        switch section {
        case .phone:
            cell.textLabel?.text = user.phone
        case .gender:
            cell.textLabel?.text = user.gender.capitalized
        case .address:
            cell.selectionStyle = .none
            cell.textLabel?.textAlignment = .justified
            cell.textLabel?.text = user.fullAddress
            cell.textLabel?.numberOfLines = 0
        case .registered:
            cell.textLabel?.text = user.registeredDate
        }
        
        return cell
    }
}
