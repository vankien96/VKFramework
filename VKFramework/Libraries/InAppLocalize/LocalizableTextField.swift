//
//  LocalizableTextField.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import UIKit

open class LocalizableTextField: UITextField, Localizable {
    
    private var localizeKey: String?
    
    override open var placeholder:String?  {
        set (newValue) {
            self.localizeKey = newValue
            super.placeholder = newValue?.localized() ?? newValue
        }
        get {
            return super.placeholder
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.localizeKey = self.placeholder
        self.placeholder = self.localizeKey
    }
    
    func updateLocalize() {
        self.placeholder = self.localizeKey
    }
    
}
