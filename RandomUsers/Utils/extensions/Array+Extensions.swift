//
//  Array+Extensions.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 10/03/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
