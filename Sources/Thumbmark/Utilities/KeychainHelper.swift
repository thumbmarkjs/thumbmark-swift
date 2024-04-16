//
//  File.swift
//
//
//  Created by Brandon Stillitano on 9/4/2024.
//

import Foundation
import Security

internal struct KeychainHelper {
    // MARK: - Constants
    private static let serviceAttribute = "ThumbmarkKeychainService"

    // MARK: - Write
    @discardableResult static func upsert<T>(_ value: T, forKey key: String) -> Bool where T: Codable {
        guard let data = try? JSONEncoder().encode(value) else { return false }
        return upsert(data, forKey: key)
    }

    private static func upsert(_ data: Data, forKey key: String) -> Bool {
        let query: CFDictionary = [kSecAttrService: serviceAttribute,
                                   kSecAttrAccount: key,
                                   kSecClass: kSecClassGenericPassword,
                                   kSecReturnData: true] as CFDictionary

        let status = SecItemAdd(query, nil)
        guard status != errSecSuccess else { return true }

        if status == errSecDuplicateItem {
            let query: CFDictionary = [kSecAttrService: serviceAttribute,
                                       kSecAttrAccount: key,
                                       kSecReturnData: true] as CFDictionary
            let updateRequest = [kSecValueData: data] as CFDictionary
            let status = SecItemUpdate(query, updateRequest)
            return status == errSecSuccess
        }
        return false
    }

    // MARK: - Read
    @discardableResult static func get<T>(_ key: String) -> T? where T: Codable {
        guard let data = get(key) else { return nil }
        guard let value: T = try? JSONDecoder().decode(T.self, from: data) else { return nil }
        return value
    }
    private static func get(_ key: String) -> Data? {
        let query = [kSecAttrService: serviceAttribute,
                     kSecAttrAccount: key,
                     kSecClass: kSecClassGenericPassword,
                     kSecReturnData: true] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return (result as? Data)
    }

    // MARK: - Delete
    static func delete(_ key: String) -> Bool {
        let query = [kSecAttrService: serviceAttribute,
                     kSecAttrAccount: key,
                     kSecClass: kSecClassGenericPassword] as CFDictionary
        let response = SecItemDelete(query)
        return response == errSecSuccess || response == errSecItemNotFound
    }
}

