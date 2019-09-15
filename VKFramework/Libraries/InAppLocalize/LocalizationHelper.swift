//
//  LocalizationHelper.swift
//  VKFramework
//
//  Created by Trương Văn Kiên on 9/15/19.
//  Copyright © 2019 Trương Văn Kiên. All rights reserved.
//

import Foundation
import Localize_Swift

open class LocalizationHelper {
    
    fileprivate var bundles = [String: Bundle]()
    var currentLanguage: String { return Localize.currentLanguage() }
    
    private let userDefaults = UserDefaults.standard
    
    private init() { }
    
    static let shared = LocalizationHelper()
    
    open func addSupportedLanguage(_ lang: String) {
        if let bundlePath = Bundle.main.path(forResource: lang, ofType: "lproj") {
            if let bundle = Bundle(path: bundlePath) {
                bundles[lang] = bundle
            }
        }
    }
    
    open func addSupportedLanguage(_ langs: [String]) {
        for lang in langs {
            addSupportedLanguage(lang)
        }
    }
    
    func setCurrentLanguage(_ lang: String) {
        Localize.setCurrentLanguage(lang)
    }
    
    func resetCurrentLanguageToDefault() {
        Localize.resetCurrentLanguageToDefault()
    }
}
