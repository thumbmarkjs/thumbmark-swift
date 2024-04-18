// The Swift Programming Language
// https://docs.swift.org/swift-book

import AVKit
import CryptoKit
import DeviceCheck
import UIKit
import DeviceCheck
import MessageUI

@MainActor public class Thumbmark {
    // MARK: - Singleton
    private init() { }
    public static var instance: Thumbmark = Thumbmark()

    // MARK: - Data
    internal var components: [ThumbmarkComponent.Type]?
    
    // MARK: - Helper Functions
    public func setAdditionalComponents(_ value: [ThumbmarkComponent.Type]?) {
        components = value
    }
}

// MARK: - Fingerprinting
public extension Thumbmark {
    var fingerprint: Fingerprint {
        let captureDevices: [CaptureDevice] = AVCaptureDevice.videoAndAudioCaptureDevices.map({ CaptureDevice(from: $0) })

        let cpu = Processor(processorCount: SysCtl.processorCount,
                            activeProcessors: SysCtl.activeCPUs,
                            architecture: UIDevice.current.architecture,
                            kernelVersion: SysCtl.kernelVersion)

        let device = Device(machine: SysCtl.model,
                            model: SysCtl.machine,
                            hostName: SysCtl.hostName,
                            deviceName: UIDevice.current.name,
                            osVersion: SysCtl.osVersion,
                            osRelease: SysCtl.osRelease)

        let memory = Memory(ram: ProcessInfo.processInfo.physicalMemory,
                            diskSize: UIDevice.current.totalDiskSpace)

        let accessibility = Accessibility(isBoldTextEnabled: UIAccessibility.isBoldTextEnabled,
                                          isShakeToUndoEnabled: UIAccessibility.isShakeToUndoEnabled,
                                          isReduceMotionEnabled: UIAccessibility.isReduceMotionEnabled,
                                          isDarkerSystemColorsEnabled: UIAccessibility.isDarkerSystemColorsEnabled,
                                          isReduceTransparencyEnabled: UIAccessibility.isReduceTransparencyEnabled,
                                          isAssistiveTouchRunning: UIAccessibility.isAssistiveTouchRunning,
                                          preferredContentSizeCategory: UIApplication.shared.preferredContentSizeCategory.rawValue,
                                          darkModeEnabled: UITraitCollection.current.userInterfaceStyle == .dark)

        let locality = Locality(identifier: Locale.current.identifier,
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

        let communication = Communication(canSendMail: MFMailComposeViewController.canSendMail(),
                                          canSendMessages: MFMessageComposeViewController.canSendText(),
                                          canSendSubject: MFMessageComposeViewController.canSendSubject(),
                                          canSendAttachments: MFMessageComposeViewController.canSendAttachments())

        return Fingerprint(captureDevices: captureDevices,
                           processor: cpu,
                           device: device,
                           memory: memory,
                           accessibility: accessibility,
                           locality: locality,
                           communication: communication,
                           components: componentsMap)
    }
}

// MARK: - ID Helpers
public extension Thumbmark {
    var id: String? {
        return id(using: SHA256.self)
    }

    func id(using hashFunction: any HashFunction.Type) -> String? {
        return id(using: hashFunction, withFingerprint: fingerprint)
    }
    
    func id(using hashFunction: any HashFunction.Type, withFingerprint: Fingerprint) -> String? {
        let encoder: JSONEncoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        guard let encodedValue = try? encoder.encode(fingerprint).base64EncodedString() else { return nil }
        guard let data = encodedValue.data(using: .utf8) else { return nil }
        let hashed = hashFunction.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    var vendorId: UUID? {
        return KeychainHelper.vendorId
    }
}

// MARK: - Private Data Helpers
private extension Thumbmark {
    var componentsMap: [String: [String: String]] {
        var value: [String: [String: String]] = [:]
        for component in self.components ?? [] {
            value[component.key] = component.values
        }
        return value
    }
}
