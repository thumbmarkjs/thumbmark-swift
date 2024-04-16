//
//  File.swift
//
//
//  Created by Brandon Stillitano on 9/4/2024.
//

import UIKit

extension KeychainHelper {
    static var vendorId: UUID {
        let key: String = "ThumbmarkPersistentID"
        if let value: UUID = get(key) { return value }
        let newValue: UUID = UUID()
        upsert(newValue, forKey: key)
        return newValue
    }
}
