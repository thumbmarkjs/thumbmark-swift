//
//  File.swift
//
//
//  Created by Brandon Stillitano on 29/4/2024.
//

import Foundation

public enum ComponentVolatility: Int, CaseIterable {
    /// Component is very stable and unlikely to ever change.
    /// For example, capture devices are marked as `low` as these are
    /// hardware components baked into the device, and are not able to change.
    case low = 0

    /// Component is somewhat stable and is subject to change with some notice.
    /// For example, user acecssibility settings are marked as `medium` as it is unlikely that
    /// these would change day to day, but it is foreseeable that they may as the users accessibility needs change over time.
    case medium = 1

    /// Component is extremely unstable and values are likely to be extremely fragile.
    /// For example, device metrics are marked as `high`as it is very likely that
    /// a user will update their device at some point, which would change this value.
    case high = 2
}

// MARK: - Comparable Conformance
extension ComponentVolatility: Comparable {
    public static func < (lhs: ComponentVolatility, rhs: ComponentVolatility) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    public static func > (lhs: ComponentVolatility, rhs: ComponentVolatility) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    public static func <= (lhs: ComponentVolatility, rhs: ComponentVolatility) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }

    public static func >= (lhs: ComponentVolatility, rhs: ComponentVolatility) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
}

// MARK: - Equatable Conformance
extension ComponentVolatility: Equatable {
    public static func == (lhs: ComponentVolatility, rhs: ComponentVolatility) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
