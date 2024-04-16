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
        return "9086c4282ca8d9db1b78428db175652ba96471c00147bbf7c35b165f69eb3394"
    }
}
