//
//  BaseUIViewController.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Localize_Swift

class BaseUIViewController: UIViewController {
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard (self.viewIfLoaded != nil) else { return }
        setupLocalize()
        setText()
    }
    
    private func setupLocalize() {
        NotificationCenter.default
            .rx.notification(Notification.Name(rawValue: LCLLanguageChangeNotification))
            .subscribe({ [weak self] (notification) in
                self?.onUpdateLocalize()
            }).disposed(by: bag)
    }
    
    open func onUpdateLocalize() {
//        self.view.onUpdateLocalize()
        self.setText()
    }
    
    open func setText() {
        
    }
    
    func addNotificationWhenKeyboardShowHide(window: UIWindow?) {
        //Handle when keyboard show
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: window)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: window)
    }
    
    @objc func handleKeyboardWillShow(notification: Notification) {
    }
    
    @objc func handleKeyboardWillHide(notification: Notification) {
    }
    
    func setupUIForiOSUnder11() {
        if #available(iOS 11, *) {
        } else {
            self.edgesForExtendedLayout = []
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    func getStatusBarHeight() -> CGFloat {
        if #available(iOS 12, *) {
            return self.view.window?.safeAreaInsets.top ?? 0
        } else {
            return 20
        }
    }
    
    deinit {
        print("Deinit: " + String(describing: type(of: self)))
    }
}
