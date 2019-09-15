//
//  URLs.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation

struct URLs {
    
    static var shared: URLs = URLs()
    
    private init() { }
    
    var APILoginUrl: String { return APIBaseUrl + "/login" }
    
    private var port = "3000"
    
    private var APIHost: String {
        get {
            return ""
        }
    }
    
    private var APIBaseUrl: String {
        get {
            return ""
        }
    }
}
