//
//  LoginRequest.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation

class LoginRequest: BaseRequest {
    
    init(username: String, password: String) {
        let value: [String: String] = [
            "username": username,
            "password": password
        ]
        super.init(url: URLs.shared.APILoginUrl, requestType: .post, body: value)
    }
}
