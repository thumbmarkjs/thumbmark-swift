//
//  File.swift
//  
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import AVKit
import Foundation

public struct CaptureDevice: Codable {
    public init(from device: AVCaptureDevice) {
        self.id = device.uniqueID
        self.modelId = device.modelID
        self.name = device.localizedName
        self.position = device.position.rawValue
    }
    
    public var id: String
    public var modelId: String
    public var name: String
    public var position: Int
}
