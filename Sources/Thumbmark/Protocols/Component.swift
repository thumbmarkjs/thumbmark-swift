//
//  File.swift
//
//
//  Created by Brandon Stillitano on 29/4/2024.
//

import Foundation

protocol Component {
    associatedtype ComponentType: Codable

    static var component: ComponentType { get }
    static var volatility: ComponentVolatility { get }
}

extension Component {
    static func withVolatilityThreshold(_ volatility: ComponentVolatility) -> ComponentType? {
        guard self.volatility <= volatility else { return nil }
        return component
    }
}
