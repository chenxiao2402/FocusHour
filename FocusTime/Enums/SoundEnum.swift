//
//  SoundEnum.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/11.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

enum SoundEnum: String {
    case None = "None"
    case Wind = "Wind"
    case Stream = "Stream"
    case Birds = "Birds"
    case Insects = "Insects"
    case Rain = "Rain"
    case Thunderstorm = "Thunderstorm"
}

extension SoundEnum: CaseIterable {
    static func getURL(sound: SoundEnum) -> URL {
        let path = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3")
        return URL(fileURLWithPath: path ?? "")
    }
    
    static func getKeyList() -> [SoundEnum] {
        return SoundEnum.allCases
    }
    
    func translate() -> String {
        return LocalizationTool.translate(self.rawValue)
    }
}
