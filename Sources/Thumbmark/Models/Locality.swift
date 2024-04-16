//
//  File.swift
//  
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import Foundation

public struct Locality: Codable {
    public var identifier: String
    public var languageCode: String?
    public var regionCode: String?
    public var availableRegionCodes: Int
    public var calendarIdentifier: String
    public var timezone: String
    public var availableTimezones: Int
    public var availableKeyboards: Int
    public var twentyFourHourTimeEnabled: Bool
    public var temperatureUnit: String
    public var usesMetricSystem: Bool
}
