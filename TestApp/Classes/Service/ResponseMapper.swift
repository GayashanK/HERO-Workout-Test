//
//  ResponseMapper.swift
//  TestApp
//
//  Created by Kasun Gayashan on 12/29/20.
//

import Foundation
import ObjectMapper

class StatusResponse: Mappable {
    var status: Status?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
    }
}
