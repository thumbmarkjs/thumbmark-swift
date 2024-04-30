//
//  File.swift
//
//
//  Created by Brandon Stillitano on 29/4/2024.
//

import UIKit

struct AccessibilityComponent: Component {
    typealias ComponentType = Accessibility

    static var component: Accessibility {
        return Accessibility(isBoldTextEnabled: UIAccessibility.isBoldTextEnabled,
                             isShakeToUndoEnabled: UIAccessibility.isShakeToUndoEnabled,
                             isReduceMotionEnabled: UIAccessibility.isReduceMotionEnabled,
                             isDarkerSystemColorsEnabled: UIAccessibility.isDarkerSystemColorsEnabled,
                             isReduceTransparencyEnabled: UIAccessibility.isReduceTransparencyEnabled,
                             isAssistiveTouchRunning: UIAccessibility.isAssistiveTouchRunning,
                             preferredContentSizeCategory: UIApplication.shared.preferredContentSizeCategory.rawValue,
                             darkModeEnabled: UITraitCollection.current.userInterfaceStyle == .dark)
    }
    
    static var volatility: ComponentVolatility {
        return .medium
    }
}
