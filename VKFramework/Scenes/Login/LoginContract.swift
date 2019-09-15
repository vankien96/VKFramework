//
//  LoginContract.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation

protocol LoginView: class {
    func loginSuccess()
    func loginFailed(error: Error)
}

protocol LoginPresenter {
    func login(username: String, password: String)
}
