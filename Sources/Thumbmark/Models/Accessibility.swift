//
//  File.swift
//  
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import Foundation

public struct Accessibility: Codable {
    public var isBoldTextEnabled: Bool
    public var isShakeToUndoEnabled: Bool
    public var isReduceMotionEnabled: Bool
    public var isDarkerSystemColorsEnabled: Bool
    public var isReduceTransparencyEnabled: Bool
    public var isAssistiveTouchRunning: Bool
    public var preferredContentSizeCategory: String
    public var darkModeEnabled: Bool
}
