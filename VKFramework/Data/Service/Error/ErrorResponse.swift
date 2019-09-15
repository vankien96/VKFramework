//
//  BaseError.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import ObjectMapper

class ErrorResponse: Mappable {
    var code: Int?
    var messages: [String]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        code <- map["error.code"]
        messages <- map["error.description"]
    }
    
    func getErrorMessage() -> String? {
        if let messages = messages {
            return messages.joined(separator: "\n")
        }
        return nil
    }
}
