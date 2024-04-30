// The Swift Programming Language
// https://docs.swift.org/swift-book

import AVKit
import CryptoKit
import DeviceCheck
import UIKit
import DeviceCheck
import MessageUI

/// Actor bound class which exposes core ``Thumbmark`` functionality and properties.
/// This class is inherently thread-safe by way of being an actor. All property access is, in one way or another, thread-safe.
public actor Thumbmark {
    private init() { }

    // MARK: - Singleton
    /// Thread-safe singleton instance of the ``Thumbmark`` class.
    public static var instance: Thumbmark = Thumbmark()

    // MARK: - Data
    var components: [ThumbmarkComponent.Type]?

    // MARK: - Helper Functions
    /// Additional values that can be used to compute the ``fingerprint`` value. All values must conform to the ``ThumbmarkComponent`` protocol.
    /// - Parameter value: Array of ``ThumbmarkComponent`` values.
    public func setAdditionalComponents(_ value: [ThumbmarkComponent.Type]?) {
        components = value
    }
}

// MARK: - Fingerprinting
public extension Thumbmark {
    /// Callback based function for retrieving the `fingerprint` value.
    /// - Parameter completion: Callback that will be triggered once the `fingerprint` value has been retrieved. Returns a strongly-typed object representing the current devices known parameters.
    nonisolated func fingerprint(withCompletion completion: @escaping (Fingerprint) -> Void) {
        Task {
            let value = await fingerprint
            completion(value)
        }
    }

    /// Returns a strongly-typed object representing the current devices known parameters, allowing the highest level of volatility.
    var fingerprint: Fingerprint {
        get async {
            return fingerprint(withVolatilityThreshold: .high)
        }
    }

    /// Returns
    /// - Parameter volatility: Desired level of ``ComponentVolatility``
    /// - Returns: Returns a strongly-typed object representing the current devices known parameters, allowing the specified level of volatility.
    func fingerprint(withVolatilityThreshold volatility: ComponentVolatility) -> Fingerprint {
        let captureDevices = CaptureDevicesComponent.withVolatilityThreshold(volatility)
        let processor = ProcessorComponent.withVolatilityThreshold(volatility)
        let device = DeviceComponent.withVolatilityThreshold(volatility)
        let memory = MemoryComponent.withVolatilityThreshold(volatility)
        let accessibility = AccessibilityComponent.withVolatilityThreshold(volatility)
        let locality = LocalityComponent.withVolatilityThreshold(volatility)
        let communication = CommunicationComponent.withVolatilityThreshold(volatility)

        return Fingerprint(captureDevices: captureDevices,
                           processor: processor,
                           device: device,
                           memory: memory,
                           accessibility: accessibility,
                           locality: locality,
                           communication: communication,
                           components: componentsMap(withVolatilityThreshold: volatility))
    }
}

// MARK: - ID Helpers
public extension Thumbmark {
    /// Returns a  SHA256 hashed representation of the ``fingerprint`` property.
    var id: String? {
        get async {
            return await id(using: SHA256.self)
        }
    }
    
    /// Exposes a SHA256 hashed representation of the ``fingerprint`` property, via the provided callback.
    /// - Parameter completion: Escaping callback, exposes a ``String`` value.
    func id(withCompletion completion: @escaping (String?) -> Void) {
        Task {
            let value = await id
            completion(value)
        }
    }
    
    /// Retrieve a hashed representation of the ``fingerprint`` property, using the specified hashing algorithm.
    /// - Parameter hashFunction: Algorithm to be used for hasing.
    /// - Returns: Returns a  hashed representation of the ``fingerprint`` property, using the specified hashing algorithm.
    func id(using hashFunction: any HashFunction.Type) async -> String? {
        return await id(using: hashFunction, withFingerprint: fingerprint)
    }
    
    /// Exposes a hashed representation of the ``fingerprint`` property, using the specified hashing algorithm, via the provided callback.
    /// - Parameters:
    ///   - hashFunction: Algorithm to be used for hasing.
    ///   - completion: Escaping callback, exposes a ``String`` value.
    func id(using hashFunction: any HashFunction.Type, withCompletion completion: @escaping (String?) -> Void) {
        Task {
            let value = await id(using: hashFunction, withFingerprint: fingerprint)
            completion(value)
        }
    }
    
    /// Retrieve a hashed representation of the ``fingerprint`` property passed into the function, using the specified hashing algorithm.
    /// - Parameters:
    ///   - hashFunction: Algorithm to be used for hasing.
    ///   - fingerprint: Fingerprint object to be hashed.
    /// - Returns: Returns a  hashed representation of the ``fingerprint`` property, using the specified hashing algorithm.
    func id(using hashFunction: any HashFunction.Type, withFingerprint fingerprint: Fingerprint) async -> String? {
        let encoder: JSONEncoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        guard let encodedValue = try? encoder.encode(fingerprint).base64EncodedString() else { return nil }
        guard let data = encodedValue.data(using: .utf8) else { return nil }
        let hashed = hashFunction.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    /// Exposes a hashed representation of the ``fingerprint`` property passed into the function, using the specified hashing algorithm, via the provided callback.
    /// - Parameters:
    ///   - hashFunction: Algorithm to be used for hasing.
    ///   - fingerprint: Fingerprint object to be hashed.
    ///   - completion: Escaping callback, exposes a ``String`` value.
    func id(using hashFunction: any HashFunction.Type, withFingerprint fingerprint: Fingerprint, andCompletion completion: @escaping (String?) -> Void) {
        Task {
            let value = await id(using: hashFunction, withFingerprint: fingerprint)
            completion(value)
        }
    }
    
    /// UUID value, persisted to the keychain during "first launch", and subsequently retrieved thereafter.
    /// Persists between app installs, uninstalls and re-installs aswell as factory resets when iCloud keychain is enabled.
    var persistentId: UUID? {
        return KeychainHelper.persistentId
    }
}

// MARK: - Private Data Helpers
private extension Thumbmark {
    func componentsMap(withVolatilityThreshold volatility: ComponentVolatility) -> [String: [String: String]] {
        var value: [String: [String: String]] = [:]
        for component in self.components?.filter({ $0.volatility <= volatility }) ?? [] {
            value[component.key] = component.values
        }
        return value
    }
}
