//
//  TokenManager.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import RxCocoa
import UICKeyChainStore
import Alamofire
import ObjectMapper

private struct KeyChainKey {
    static let userToken = "userToken"
}

class TokenManager {
    
    static let shared = TokenManager()
    let keychain = UICKeyChainStore()
    private var token: Token?
    
    var isChangeToken = BehaviorRelay<Bool>(value: false)
    
    private init() { }
    
    func saveToken(token: Token) {
        self.token = token
        let tokenData = NSKeyedArchiver.archivedData(withRootObject: token)
        keychain.setData(tokenData, forKey: KeyChainKey.userToken)
        isChangeToken.accept(true)
    }
    
    func getToken() -> Token? {
        if let token = token {
            return token
        }
        guard let tokenData = keychain.data(forKey: KeyChainKey.userToken),
            let token = NSKeyedUnarchiver.unarchiveObject(with: tokenData) as? Token else { return nil }
        self.token = token
        return token
    }
    
    func removeToken() {
        keychain[KeyChainKey.userToken] = nil
        self.token = nil
    }
    
    func refreshToken(completion: @escaping ((Bool) -> Void)) {
        guard let token = self.getToken() else { completion(false); return }
        let input = RefreshTokenRequest(token: token)
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept-Language": LocalizationHelper.shared.currentLanguage
        ]
        Alamofire.request(input.url, method: input.requestType, parameters: input.body, encoding: input.encoding, headers: headers)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    if let statusCode = response.response?.statusCode,
                        statusCode == 200,
                        let token = Mapper<Token>().map(JSONObject: value) {
                        TokenManager.shared.saveToken(token: token)
                        completion(true)
                    } else {
                        completion(false)
                    }
                default:
                    completion(false)
                }
        }
    }
}
