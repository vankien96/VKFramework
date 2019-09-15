//
//  LoginViewController.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation

class LoginViewController: BaseUIViewController {
    
    private var presenter: LoginPresenter!
    private var navigator: LoginNavigator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenterImpl(view: self, userRepository: UserRepositoryImpl.shared)
        navigator = LoginNavigatorImpl(viewController: self)
    }
}

extension LoginViewController: LoginView {
    
    func loginSuccess() {
        self.navigator.toMainScreen()
    }
    
    func loginFailed(error: Error) {
        self.showAlertWithMessage(message: error.localizedDescription)
    }
}
