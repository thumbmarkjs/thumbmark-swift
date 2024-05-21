//
//  File.swift
//
//
//  Created by Brandon Stillitano on 9/4/2024.
//

import Foundation
import SimpleKeychain

internal struct KeychainHelper {
    // MARK: - Constants
    private static let keychainValueKey: String = "ThumbmarkPersistentID"
    private static let serviceAttribute = "ThumbmarkKeychainService"
    private static let keychain = SimpleKeychain(service: serviceAttribute)

    // MARK: - Write
    static func upsert<T>(_ value: T, forKey key: String) where T: Codable {
        guard let data = try? JSONEncoder().encode(value) else { return }
        try? keychain.set(data, forKey: key)
    }

    // MARK: - Read
    @discardableResult static func get<T>(_ key: String) -> T? where T: Codable {
        guard let data = try? keychain.data(forKey: key) else { return nil }
        guard let value: T = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        return value
    }

    // MARK: - Delete
    static func delete(_ key: String) -> Bool {
        try? keychain.deleteItem(forKey: key)
        return (try? keychain.hasItem(forKey: key)) == false
    }
}

extension KeychainHelper {
    static func persistentId(withExpiry days: Int? = nil) -> UUID {
        if let value: PersistentIdentifier = get(keychainValueKey) {
            if let validNumberOfDays = days {
                if let elapsedDays = Calendar.current.numberOfDaysBetween(value.createdAt, and: Date()), elapsedDays <= validNumberOfDays {
                    return value.id
                } // Fallthrough to `newValue` if this fails.
            } else {
                return value.id
            }
        }
        let newValue: PersistentIdentifier = PersistentIdentifier(id: UUID(), createdAt: Date())
        upsert(newValue, forKey: keychainValueKey)
        return newValue.id
    }
}
