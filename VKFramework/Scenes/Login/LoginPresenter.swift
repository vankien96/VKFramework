//
//  LoginPresenter.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import RxSwift

class LoginPresenterImpl: LoginPresenter {
    
    private weak var view: LoginView?
    private var userRepository: UserRepository!
    private var bag = DisposeBag()
    
    init(view: LoginView, userRepository: UserRepository) {
        self.view = view
        self.userRepository = userRepository
    }
    
    func login(username: String, password: String) {
        userRepository.login(username: username, password: password)
            .subscribe(onSuccess: { [weak self] (response) in
                guard let token = response.token else {
                    self?.view?.loginFailed(error: BaseError.unexpectedError)
                    return
                }
                self?.view?.loginSuccess()
                TokenManager.shared.saveToken(token: token)
            }) { [weak self] (error) in
                self?.view?.loginFailed(error: error)
        }.disposed(by: bag)
    }
}
