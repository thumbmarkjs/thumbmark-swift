//
//  File.swift
//  
//
//  Created by Brandon Stillitano on 9/4/2024.
//

@testable import Thumbmark
import Foundation

struct MockComponent: Codable {
    static var value: String {
        return "Some static value"
    }
}

extension MockComponent: ThumbmarkComponent {
    static var key: String { return "mockComponent"}
    static var values: [String : String] = ["value": value]
    static var volatility: ComponentVolatility { return .low }
}
