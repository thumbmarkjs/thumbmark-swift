//
//  File.swift
//
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import Foundation

internal func merge(_ lhs: [String: Any], _ rhs: [String: Any]) -> [String: Any] {
    var value = lhs
    let lhsKeys = lhs.keys
    let rhsKeys = rhs.keys
    for key in rhsKeys {
        if !lhsKeys.contains(key) {
            value[key] = rhs[key]
        } else {
            let rightValue = rhs[key]
            let leftValue = lhs[key]
            switch (leftValue, rightValue) {
            case let (leftDictionary, rightDictionary) as ([String: Any], [String: Any]):
                value[key] = merge(leftDictionary, rightDictionary)
            default:
                value[key] = rightValue
            }
        }
    }
    return value
}
