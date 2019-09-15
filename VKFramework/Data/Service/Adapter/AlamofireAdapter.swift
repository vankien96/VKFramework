//
//  AlamofireAdapter.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import Alamofire

final class APIRequestAdapter: RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let token = TokenManager.shared.getToken() {
            urlRequest.setValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
        }
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(LocalizationHelper.shared.currentLanguage, forHTTPHeaderField: "Accept-Language")
        return urlRequest
    }
}
