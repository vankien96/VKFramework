//
//  RefreshTokenRequest.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation

class RefreshTokenRequest: BaseRequest {
    
    init(token: Token) {
        let value: [String: String] = [
            "refresh_token": token.refreshToken
        ]
        super.init(url: URLs.shared.APILoginUrl, requestType: .post, body: value)
    }
}
