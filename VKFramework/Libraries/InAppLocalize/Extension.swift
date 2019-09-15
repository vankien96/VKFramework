//
//  Extension.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import UIKit

extension UIView {
    
    func onUpdateLocalize() {
        for subView: UIView in self.subviews {
            subView.onUpdateLocalize()
            if let localizeSubView = subView as? Localizable {
                localizeSubView.updateLocalize()
            }
        }
    }
}

protocol Localizable {
    func updateLocalize()
}
