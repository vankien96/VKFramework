//
//  User.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var id = ""
    var name = ""
    var avatar = ""
    var email = ""
    var phoneNumber = ""
    var address = ""
    var birthday: Date?
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        let dateTransform = DateFormatterTransform(dateFormatter: Formatter.dateOnly)
        id <- map["id"]
        name <- map["name"]
        avatar <- map["avatar"]
        phoneNumber <- map["phoneNumber"]
        email <- map["email"]
        address <- map["address"]
        birthday <- (map["birthday"], dateTransform)
    }
}
