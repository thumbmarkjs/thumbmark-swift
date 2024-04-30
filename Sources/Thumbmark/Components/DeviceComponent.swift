//
//  File.swift
//
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import UIKit

struct DeviceComponent: Component {
    typealias ComponentType = Device

    static var component: Device {
        return Device(machine: SysCtl.model,
                      model: SysCtl.machine,
                      hostName: SysCtl.hostName,
                      deviceName: UIDevice.current.name,
                      osVersion: SysCtl.osVersion,
                      osRelease: SysCtl.osRelease)
    }
    
    static var volatility: ComponentVolatility {
        return .high
    }
}
