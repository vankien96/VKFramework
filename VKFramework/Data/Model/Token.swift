//
//  Token.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import ObjectMapper

struct TokenKey {
    static let expireIn = "accessTokenExpiresAt"
    static let accessToken = "accessToken"
    static let refreshToken = "refreshToken"
    static let refreshTokenExpireIn = "refreshTokenExpiresAt"
    static let userID = "userID"
}

class Token: NSObject, Mappable, NSCoding {
    
    var expireIn: Int = 0
    var accessToken: String = ""
    var refreshToken: String = ""
    var refreshTokenExpireIn: Int = 0
    var userID: String = ""
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.expireIn = aDecoder.decodeInteger(forKey: TokenKey.expireIn)
        self.refreshTokenExpireIn = aDecoder.decodeInteger(forKey: TokenKey.refreshTokenExpireIn)
        self.accessToken = (aDecoder.decodeObject(forKey: TokenKey.accessToken) as? String) ?? ""
        self.refreshToken = (aDecoder.decodeObject(forKey: TokenKey.refreshToken) as? String) ?? ""
        self.userID = (aDecoder.decodeObject(forKey: TokenKey.userID) as? String) ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(expireIn, forKey: TokenKey.expireIn)
        aCoder.encode(accessToken, forKey: TokenKey.accessToken)
        aCoder.encode(refreshToken, forKey: TokenKey.refreshToken)
        aCoder.encode(refreshTokenExpireIn, forKey: TokenKey.refreshTokenExpireIn)
        aCoder.encode(userID, forKey: TokenKey.userID)
    }
    
    override init() {
    }
    
    required init?(map: Map) {
        super.init()
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {
        let datetimeTransform = DateFormatterTransform(dateFormatter: Formatter.default)
        accessToken <- map[TokenKey.accessToken]
        refreshToken <- map[TokenKey.refreshToken]
        var accessTokenExpireDate: Date?
        accessTokenExpireDate <- (map[TokenKey.expireIn], datetimeTransform)
        expireIn = Int(accessTokenExpireDate?.toTimestampSecond() ?? 0)
        var refreshTokenExpireDate: Date?
        refreshTokenExpireDate <- (map[TokenKey.refreshTokenExpireIn], datetimeTransform)
        refreshTokenExpireIn = Int(refreshTokenExpireDate?.toTimestampSecond() ?? 0)
        userID <- map["user._id"]
    }
    
    func isValidAccessToken() -> Bool {
        return !accessToken.isEmpty && !isAccessTokenExpired()
    }
    
    func isValidRefreshToken() -> Bool {
        return !refreshToken.isEmpty && !isRefreshTokenExpired()
    }
    
    private func isAccessTokenExpired() -> Bool {
        guard expireIn > 0 else { return true }
        return expireIn < Int(Date().timeIntervalSince1970)
    }
    
    private func isRefreshTokenExpired() -> Bool {
        guard refreshTokenExpireIn > 0 else { return true }
        return refreshTokenExpireIn < Int(Date().timeIntervalSince1970)
    }
}
