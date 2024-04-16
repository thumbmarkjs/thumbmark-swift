//
//  File.swift
//
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import AVKit

public extension AVCaptureDevice {
    /// Returns an array of ``AVCaptureDevice`` values, representing all video cameras on the current device.
    static var videoCaptureDevices: [AVCaptureDevice] {
        #if os(iOS)
            let session = AVCaptureDevice.DiscoverySession(
                deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera],
                mediaType: .video,
                position: .unspecified)
        #elseif os(macOS)
            let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(
                deviceTypes: [.builtInWideAngleCamera],
                mediaType: .video,
                position: .unspecified)
        #endif
        return session.devices
    }

    /// Returns an array of ``AVCaptureDevice`` values, representing all built-in microphones on the current device.
    static var audioCaptureDevices: [AVCaptureDevice] {
        let session = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInMicrophone],
            mediaType: .audio,
            position: .unspecified)
        return session.devices
    }
    
    /// Returns an array of ``AVCaptureDevice`` values, representing all video cameras AND all built-in microphones on the current device.
    static var videoAndAudioCaptureDevices: [AVCaptureDevice] {
        return videoCaptureDevices + audioCaptureDevices
    }
}
