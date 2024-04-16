//
//  File.swift
//
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import Foundation

public struct Fingerprint: Codable {
    public var captureDevices: [CaptureDevice]
    public var processor: Processor
    public var device: Device
    public var memory: Memory
    public var accessibility: Accessibility
    public var locality: Locality
    public var communication: Communication
    public var components: [String: [String: String]]
}
