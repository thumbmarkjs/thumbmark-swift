//
//  File.swift
//
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import Foundation

public protocol ThumbmarkComponent where Self: Codable {
    static var key: String { get }
    static var values: [String: String] { get }
    static var volatility: ComponentVolatility { get }
}
