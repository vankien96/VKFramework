//
//  LocalizableButton.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import UIKit

open class LocalizableButton: UIButton, Localizable {
    
    private var localizeKey: String?
    
    override open func setTitle(_ title: String?, for state: UIControl.State) {
        if let key = title {
            self.localizeKey = key
            super.setTitle(key.localized(), for: state)
        } else {
            super.setTitle(title, for: state)
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.localizeKey = self.currentTitle
        self.setTitle(self.localizeKey, for: .normal)
    }
    
    func updateLocalize() {
        self.setTitle(self.localizeKey, for: .normal)
    }
    
}
