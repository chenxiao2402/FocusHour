//
//  SoundEnum.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/11.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

enum SoundKey: String {
    case None = "None"
    case Wind = "Wind"
    case Stream = "Stream"
    case Birds = "Birds"
    case Insects = "Insects"
    case Rain = "Rain"
    case Thunderstorm = "Thunderstorm"
}

extension SoundKey: CaseIterable {
    static func getURL(sound: SoundKey) -> URL {
        let path = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3")
        return URL(fileURLWithPath: path ?? "")
    }
    
    static func getKeyList() -> [SoundKey] {
        return SoundKey.allCases
    }
    
    func translate() -> String {
        return LocalizationTool.translate(self.rawValue)
    }
}
