//
//  UIViewControllerExtension.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func removeBackButtonTitle() {
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    func showAlertWithMessage(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: Strings.Main.appName, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Strings.Main.done, style: .cancel) { (action) in
            completion?()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showConfirmMessage(message: String, customMessage: NSAttributedString? = nil, titleNoButton: String? = nil, titleYesButton: String? = nil, clickNoButton: (() -> Void)? = nil, clickYesButton: (() -> Void)? = nil) {
        let alert = UIAlertController(title: Strings.Main.appName, message: message, preferredStyle: .alert)
        let no = UIAlertAction(title: titleNoButton ?? Strings.Main.no, style: .cancel) { (action) in
            clickNoButton?()
        }
        let yes = UIAlertAction(title: titleYesButton ?? Strings.Main.yes, style: .default) { (action) in
            clickYesButton?()
        }
        alert.addAction(no)
        alert.addAction(yes)
         self.present(alert, animated: true, completion: nil)
    }
}
