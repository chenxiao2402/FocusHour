//
//  SoundEnum.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/11.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

enum SettingKey: String {
    case Settings = "Settings"
    case SetLanguage = "SetLanguage"
    case About = "About"
}

extension SettingKey {
    func translate() -> String {
        return LocalizationTool.translate(self.rawValue)
    }
}
