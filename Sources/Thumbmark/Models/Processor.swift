//
//  File.swift
//  
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import Foundation

public struct Processor: Codable {
    public var processorCount: Int32
    public var activeProcessors: Int32
    public var architecture: String?
    public var kernelVersion: String
}
