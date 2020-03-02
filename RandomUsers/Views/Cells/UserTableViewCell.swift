//
//  UserTableViewCell.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 01/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
    static let userCellIdentifier = "userCellIdentifier"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ model: UserInfo) {
        if let url = URL(string: model.imageUrl) {
            profileImageView.imageFromUrl(url: url)
        }
        
        profileImageView.applyStyle(for: .profile)
        nameLabel.text = model.fullName
        emailLabel.text = model.email
        phoneLabel.text = model.phone
    }
}
