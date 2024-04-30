//
//  File.swift
//
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import AVKit
import Foundation

struct CaptureDevicesComponent: Component {
    typealias ComponentType = [CaptureDevice]

    static var component: [CaptureDevice] {
        return AVCaptureDevice.videoAndAudioCaptureDevices.map({ CaptureDevice(from: $0) })
    }
    
    static var volatility: ComponentVolatility {
        return .low
    }
}
