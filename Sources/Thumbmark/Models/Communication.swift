//
//  File.swift
//  
//
//  Created by Brandon Stillitano on 8/4/2024.
//

import Foundation

public struct Communication: Codable {
    public var canSendMail: Bool
    public var canSendMessages: Bool
    public var canSendSubject: Bool
    public var canSendAttachments: Bool
}
