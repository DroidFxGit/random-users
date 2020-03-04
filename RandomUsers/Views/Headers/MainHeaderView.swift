//
//  MainHeaderView.swift
//  resume app
//
//  Created by Carlos Vázquez Gómez on 02/03/20.
//  Copyright © 2019 Carlos Vázquez Gómez. All rights reserved.
//

import UIKit

struct MainHeaderModel {
    let name: String
    let email: String
    let profileURL: String
}

class MainHeaderView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            self.profileImageView.applyStyle(for: .profile)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed("MainHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func configure(model: MainHeaderModel) {
        profileImageView.imageFromUrl(url: URL(string: model.profileURL)!)
        nameLabel.text = model.name
        emailLabel.text = model.email
    }
}

