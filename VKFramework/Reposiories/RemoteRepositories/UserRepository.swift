//
//  UserRepository.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepository {
    func login(username: String, password: String) -> Single<LoginResponse>
}

class UserRepositoryImpl: UserRepository {
    
    static let shared = UserRepositoryImpl()
    
    func login(username: String, password: String) -> Single<LoginResponse> {
        let loginRequest = LoginRequest(username: username, password: password)
        return APIService.shared.request(input: loginRequest).asSingle()
    }
}
