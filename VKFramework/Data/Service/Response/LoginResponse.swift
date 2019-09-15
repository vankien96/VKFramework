//
//  LoginResponse.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginResponse : Mappable {
    
    var token: Token?
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        token = Token(map: map)
    }
}
