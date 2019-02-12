//
//  LocalizationTool.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/12.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

class LocalizationTool {
    
    static func setSystemLanguage(_ language: LanguageEnum) {
        // let languages: NSArray = UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray
        // print("切换之前: \(languages)")

        // 切换语言
        let languageCodeNames = LanguageEnum.getCodeNames(startWith: language)
        UserDefaults.standard.set(languageCodeNames, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        Bundle.main.onLanguage()
    }
}
