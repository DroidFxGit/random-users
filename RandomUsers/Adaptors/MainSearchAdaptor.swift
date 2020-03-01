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
    private let kHeightRow: CGFloat = 200.0
    private let kHeightFooter: CGFloat = 40.0
    
    func setupAdaptor() {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
