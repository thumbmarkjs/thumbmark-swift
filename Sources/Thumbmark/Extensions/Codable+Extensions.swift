//
//  File.swift
//
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import Foundation

public extension Encodable {
    /// ``[String: Any]`` representation of this value
    var dictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)).flatMap { $0 as? [String: Any] } ?? [:]
    }
}
