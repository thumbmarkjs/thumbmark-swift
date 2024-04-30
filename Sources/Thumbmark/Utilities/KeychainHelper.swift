//
//  File.swift
//
//
//  Created by Brandon Stillitano on 9/4/2024.
//

import Foundation
import KeychainAccess

internal struct KeychainHelper {
    // MARK: - Constants
    private static let serviceAttribute = "ThumbmarkKeychainService"
    private static let keychain = Keychain(service: serviceAttribute)

    // MARK: - Write
    @discardableResult static func upsert(_ value: String, forKey key: String) -> Bool {
        try? keychain.set(value, key: key)
        return (try? keychain.get(key)) == value
    }

    // MARK: - Read
    @discardableResult static func get(_ key: String) -> String? {
        return try? keychain.get(key)
    }

    // MARK: - Delete
    static func delete(_ key: String) -> Bool {
        try? keychain.remove(key)
        return get(key) == nil
    }
}

extension KeychainHelper {
    static var persistentId: UUID {
        let key: String = "ThumbmarkPersistentID"
        if let storedValue = get(key), let value: UUID = UUID(uuidString: storedValue) { return value }
        let newValue: UUID = UUID()
        upsert(newValue.uuidString, forKey: key)
        return newValue
    }
}
