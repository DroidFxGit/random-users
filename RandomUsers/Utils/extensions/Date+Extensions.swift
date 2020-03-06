//
//  Date+Extensions.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 04/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation

extension Date {
    var stringDate: String {
        let formatter = DateFormatter.readableDateFormatter
        return formatter.string(from: self)
    }
}
