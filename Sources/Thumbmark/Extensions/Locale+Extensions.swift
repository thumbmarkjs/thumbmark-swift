//
//  File.swift
//
//
//  Created by Brandon Stillitano on 29/4/2024.
//

import Foundation

public extension Locale {
    var twentyFourHourTimeEnabled: Bool {
        let dateFormat = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: self)
        return dateFormat?.range(of: "a") == nil
    }

    var temperatureUnit: UnitTemperature {
        let units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
        let measurement = Measurement(value: 37, unit: UnitTemperature.celsius)
        let temperatureString = MeasurementFormatter().string(from: measurement)
        let matchedUnit = units.first { temperatureString.contains($0.symbol) }
        if let matchedUnit = matchedUnit { return matchedUnit }
        return usesMetricSystem ? .celsius : .fahrenheit
    }
}
