//
//  DateFormatter+Extensions.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 04/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let commonDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = .gregorian
        return formatter
    }()
    
    static let readableDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.calendar = .gregorian
        return formatter
    }()
}
