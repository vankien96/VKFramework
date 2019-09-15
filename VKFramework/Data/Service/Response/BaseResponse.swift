//
//  BaseResponse.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse<T: Mappable>: Mappable {
    var status: Int = 0
    var dataResponse: [T]?
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        dataResponse <- map["data"]
    }
}
