//
//  File.swift
//
//
//  Created by Brandon Stillitano on 9/4/2024.
//

@testable import Thumbmark
import Foundation

struct MockFingerprint {
    /// Static fingerprint value used only for testing. Ensures values are known at compile time.
    static var fingerprint: Fingerprint {
        let cpu = Processor(processorCount: 8,
                            activeProcessors: 8,
                            architecture: "arm64e",
                            kernelVersion: "23.2.0")

        let device = Device(machine: "ABC123",
                            model: "iPhone15,1",
                            hostName: "localhost",
                            deviceName: "Brandon's iPhone",
                            osVersion: "23.2.0",
                            osRelease: "23.2.0")

        let memory = Memory(ram: 1234567890,
                            diskSize: 9876543210)

        let accessibility = Accessibility(isBoldTextEnabled: true,
                                          isShakeToUndoEnabled: false,
                                          isReduceMotionEnabled: true,
                                          isDarkerSystemColorsEnabled: false,
                                          isReduceTransparencyEnabled: true,
                                          isAssistiveTouchRunning: false,
                                          preferredContentSizeCategory: "Large",
                                          darkModeEnabled: false)

        let locality = Locality(identifier: "en-AU",
                                languageCode: "en-AU",
                                regionCode: "AU",
                                availableRegionCodes: 472,
                                calendarIdentifier: "gregorian",
                                timezone: "Australia/Sydney",
                                availableTimezones: 115,
                                availableKeyboards: 2,
                                twentyFourHourTimeEnabled: false,
                                temperatureUnit: "ºC",
                                usesMetricSystem: true)

        let communication = Communication(canSendMail: true,
                                          canSendMessages: false,
                                          canSendSubject: true,
                                          canSendAttachments: false)

        return Fingerprint(captureDevices: [],
                           processor: cpu,
                           device: device,
                           memory: memory,
                           accessibility: accessibility,
                           locality: locality,
                           communication: communication,
                           components: [:])
    }
    
    /// The mocked fingerprint above should always return this value when hashed via ``Thumbmark.instance.id(using:withFingerprint:)``
    static var expectedId: String {
        return "b3af821767efe443821ecbc1a1b3c3c2ad5a8d49b701e07d214910115c9a8c73"
    }
}
