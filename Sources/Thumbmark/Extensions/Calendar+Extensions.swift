//
//  File.swift
//
//
//  Created by Brandon Stillitano on 30/4/2024.
//

import Foundation

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int? {
        let components = dateComponents([.day], from: from, to: to)
        return components.day
    }
}
