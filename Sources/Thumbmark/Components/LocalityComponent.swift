//
//  File.swift
//
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import Foundation

struct LocalityComponent: Component {
    typealias ComponentType = Locality

    static var component: Locality {
        return Locality(identifier: Locale.current.identifier,
                        languageCode: Locale.current.languageCode,
                        regionCode: Locale.current.regionCode,
                        availableRegionCodes: Locale.isoRegionCodes.count,
                        calendarIdentifier: String(describing: Locale.current.calendar.identifier),
                        timezone: TimeZone.current.identifier,
                        availableTimezones: TimeZone.knownTimeZoneIdentifiers.count,
                        availableKeyboards: UserDefaults.standard.array(forKey: "AppleKeyboards")?.count ?? 0,
                        twentyFourHourTimeEnabled: Locale.current.twentyFourHourTimeEnabled,
                        temperatureUnit: Locale.current.temperatureUnit.symbol,
                        usesMetricSystem: Locale.current.usesMetricSystem)
    }
    
    static var volatility: ComponentVolatility {
        return .medium
    }
}
