//
//  File.swift
//
//
//  Created by Brandon Stillitano on 29/4/2024.
//

import Foundation
import MessageUI

struct CommunicationComponent: Component {
    typealias ComponentType = Communication

    static var component: Communication {
        return Communication(canSendMail: MFMailComposeViewController.canSendMail(),
                             canSendMessages: MFMessageComposeViewController.canSendText(),
                             canSendSubject: MFMessageComposeViewController.canSendSubject(),
                             canSendAttachments: MFMessageComposeViewController.canSendAttachments())
    }
    
    static var volatility: ComponentVolatility {
        return .medium
    }
}
