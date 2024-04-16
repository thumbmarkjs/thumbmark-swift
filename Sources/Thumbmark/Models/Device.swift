//
//  File.swift
//  
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import Foundation

public struct Device: Codable {
    public var machine: String
    public var model: String
    public var hostName: String
    public var deviceName: String
    public var osVersion: String
    public var osRelease: String
}
