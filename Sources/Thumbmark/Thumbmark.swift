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
    var volatility: ComponentVolatility = .high

    // MARK: - Helper Functions
    /// Additional values that can be used to compute the ``fingerprint`` value. All values must conform to the ``ThumbmarkComponent`` protocol.
    /// - Parameter value: Array of ``ThumbmarkComponent`` values.
    public func setAdditionalComponents(_ value: [ThumbmarkComponent.Type]?) {
        components = value
    }

    /// Sets additional values that can be used to compute the ``fingerprint`` value. All values must conform to the ``ThumbmarkComponent`` protocol.
    /// - Parameters:
    ///   - value: Array of ``ThumbmarkComponent`` values.
    ///   - completion: Void block called when operation has finished
    nonisolated public func setAdditionalComponents(_ value: [ThumbmarkComponent.Type]?, withCompletion completion: (() -> Void)? = nil) {
        Task {
            await setAdditionalComponents(value)
            completion?()
        }
    }

    /// Sets the accepted level of "volatility" that will be used when producing id's and fingerprints
    /// - Parameter value: ``ComponentVolatility`` preset
    public func setVolatility(_ value: ComponentVolatility) {
        volatility = value
    }
    
    /// Sets the accepted level of "volatility" that will be used when producing id's and fingerprints
    /// - Parameters:
    ///   - value: ``ComponentVolatility`` preset
    ///   - completion: Void block called when operation has finished
    nonisolated public func setVolatility(_ value: ComponentVolatility, withCompletion completion: (() -> Void)? = nil) {
        Task {
            await setVolatility(value)
            completion?()
        }
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

    /// Returns a strongly-typed object representing the current devices known parameters, allowing the specified level of volatility, by default this is set to `.high`.
    var fingerprint: Fingerprint {
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
                           components: componentsMap)
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
    nonisolated func id(withCompletion completion: @escaping (String?) -> Void) {
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
    nonisolated func id(using hashFunction: any HashFunction.Type, withCompletion completion: @escaping (String?) -> Void) {
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
    nonisolated func id(using hashFunction: any HashFunction.Type, withFingerprint fingerprint: Fingerprint, andCompletion completion: @escaping (String?) -> Void) {
        Task {
            let value = await id(using: hashFunction, withFingerprint: fingerprint)
            completion(value)
        }
    }

    /// UUID value, persisted to the keychain during "first launch", and subsequently retrieved thereafter.
    /// Persists between app installs, uninstalls and re-installs aswell as factory resets when iCloud keychain is enabled.
    /// - Parameter days: Number of days that the value should be valid
    /// - Returns: ``UUID`` value
    func persistentId(withExpiry days: Int? = nil) -> UUID? {
        return KeychainHelper.persistentId(withExpiry: days)
    }

    /// UUID value, persisted to the keychain during "first launch", and subsequently retrieved thereafter.
    /// Persists between app installs, uninstalls and re-installs aswell as factory resets when iCloud keychain is enabled.
    /// - Parameter days: Number of days that the value should be valid
    ///   - completion: Escaping callback, exposes an optional``UUID`` value.
    nonisolated func persistentId(withExpiry days: Int? = nil, andCompletion completion: @escaping (UUID?) -> Void) {
        let value = KeychainHelper.persistentId(withExpiry: days)
        completion(value)
    }
}

// MARK: - Private Data Helpers
private extension Thumbmark {
    var componentsMap: [String: [String: String]] {
        var value: [String: [String: String]] = [:]
        for component in self.components?.filter({ $0.volatility <= self.volatility }) ?? [] {
            value[component.key] = component.values
        }
        return value
    }
}
