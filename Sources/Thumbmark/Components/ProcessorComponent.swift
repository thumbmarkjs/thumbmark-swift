//
//  File.swift
//
//
//  Created by Brandon Stillitano on 29/4/2024.
//

import UIKit

struct ProcessorComponent: Component {
    typealias ComponentType = Processor

    static var component: Processor {
        return Processor(processorCount: SysCtl.processorCount,
                         activeProcessors: SysCtl.activeCPUs,
                         architecture: UIDevice.current.architecture,
                         kernelVersion: SysCtl.kernelVersion)
    }

    static var volatility: ComponentVolatility {
        return .medium
    }
}
