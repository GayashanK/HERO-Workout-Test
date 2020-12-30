//
//  User.swift
//  TestApp
//
//  Created by Kasun Gayashan on 12/29/20.
//

import Foundation
import ObjectMapper

class User: NSObject, Mappable {
 
    var email: String?
    var password: String?
    
    override init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        email <- map["email"]
        password <- map["password"]
    }
    
}
