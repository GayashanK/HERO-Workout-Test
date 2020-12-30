//
//  Struct.swift
//  TestApp
//
//  Created by Kasun Gayashan on 12/29/20.
//

import Foundation
import UIKit

struct Global {
    static let os_type = "iOS"
    static let title = "App Name"
    static let contact_support = "Please contact support"
}

struct Colors {
    static let primaryColor = UIColor(hex: "0x8d8d8d")
    static let errorColor = UIColor(hex: "0xd0021b")
}

struct Network {
    #if DEBUG
    static let baseUrl = "https://localhost:5001/"
    #else
    static let baseUrl = "http://localhost:8080/"
    #endif
}
