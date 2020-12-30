//
//  Status.swift
//  TestApp
//
//  Created by Kasun Gayashan on 12/29/20.
//

import Foundation
import ObjectMapper

class Status: NSObject, Mappable {
 
    var reason: String?
    var status: String?
    var statusCode: Int?
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        reason <- map["reason"]
        status <- map["status"]
        statusCode <- map["statusCode"]
    }
    
}


