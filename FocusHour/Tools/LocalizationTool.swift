//
//  LocalizationTool.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/12.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

class LocalizationTool {
    
    static func setSystemLanguage(_ language: LanguageKey) {
        // let languages: NSArray = UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray
        // print("系统语言列表: \(languages)")，哦这个注释是特意留下来的

        // 切换语言
        let languageCodeNames = LanguageKey.getCodeNames(startWith: language)
        UserDefaults.standard.set(languageCodeNames, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        Bundle.main.onLanguage()
    }
    
    static func translate(_ text: String) -> String {
        return NSLocalizedString(text, comment: "")
    }
}
