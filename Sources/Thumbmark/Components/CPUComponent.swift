//
//  File.swift
//
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import MachO
import UIKit

public extension UIDevice {
    /// Returns a ``String`` representing the local architecture pointee. E.g. "arm64e"
    var architecture: String? {
        guard let pointee = NXGetLocalArchInfo().pointee.name else { return nil }
        return String(cString: pointee)
    }
}
