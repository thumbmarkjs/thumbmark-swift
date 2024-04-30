//
//  File.swift
//
//
//  Created by Brandon Stillitano on 29/4/2024.
//

import UIKit

struct MemoryComponent: Component {
    typealias ComponentType = Memory

    static var component: Memory {
        return Memory(ram: ProcessInfo.processInfo.physicalMemory,
                      diskSize: UIDevice.current.totalDiskSpace)
    }
    
    static var volatility: ComponentVolatility {
        return .low
    }
}
