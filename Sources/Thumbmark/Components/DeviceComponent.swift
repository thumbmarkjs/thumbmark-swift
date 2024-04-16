//
//  File.swift
//
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import UIKit

extension UIDevice {
    /// ``Int`` value representing the overall disk space (not available) of the device.
    var totalDiskSpace: Int {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
            let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.intValue else { return 0 }
        return space
    }
}
