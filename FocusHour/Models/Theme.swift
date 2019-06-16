//
//  ThemeKey.swift
//  FocusHour
//
//  Created by 賴健明 on 2019/6/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

enum ThemeKey: String {
    
    case LightThemeKey = "LightTheme"
    case DarkThemeKey = "DarkTheme"
    
    static let defaultDarkThemeList : [Theme] = [
        // dark theme
        Theme(index: 1, backgroundImage: "background-dark-1", themeColor: ColorKey.DarkTheme.uiColor()),
        Theme(index: 2, backgroundImage: "background-dark-2", themeColor: ColorKey.DarkTheme.uiColor()),
        Theme(index: 3, backgroundImage: "background-dark-3", themeColor: ColorKey.DarkTheme.uiColor()),
        Theme(index: 4, backgroundImage: "background-dark-4", themeColor: ColorKey.DarkTheme.uiColor()),
        Theme(index: 5, backgroundImage: "background-dark-5", themeColor: ColorKey.DarkTheme.uiColor()),
    ]
    
    static let defaultLightThemeList: [Theme] = [
        // light theme
        Theme(index: 1, backgroundImage: "background-light-1", themeColor: ColorKey.LightThemeOne.uiColor()),
        Theme(index: 2, backgroundImage: "background-light-2", themeColor: ColorKey.LightThemeTwo.uiColor()),
        Theme(index: 3, backgroundImage: "background-light-3", themeColor: ColorKey.LightThemeThree.uiColor()),
        Theme(index: 4, backgroundImage: "background-light-4", themeColor: ColorKey.LightThemeFour.uiColor()),
        Theme(index: 5, backgroundImage: "background-light-5", themeColor: ColorKey.LightThemeFive.uiColor()),
    ]
    
    func getThemeList() -> [Theme] {
        switch self {
        case .LightThemeKey:
            return ThemeKey.defaultLightThemeList
        default:
            return ThemeKey.defaultDarkThemeList
        }
    }
}

struct ThemeProperty {
    static let index = "index"
    static let backgroundImage = "backgroundImage"
    static let themeColor = "themeColor"
}

class Theme: NSObject, NSCoding {
    
    static let BaseURL = SystemConstant.DocumentsDirectory.appendingPathComponent("Themes")
    
    let index: Int
    let backgroundImage: String
    let themeColor: UIColor
    
    lazy var name: String = {
        let indexNameList: [LocalizationKey] = [.One, .Two, .Three, .Four, .Five]
        let indexName = indexNameList[index - 1].translate()
        return "\(LocalizationKey.Theme.translate())\(indexName)"
    }()
    
    init(index: Int, backgroundImage: String, themeColor: UIColor) {
        self.index = index
        self.backgroundImage = backgroundImage
        self.themeColor = themeColor
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(index, forKey: ThemeProperty.index)
        aCoder.encode(backgroundImage, forKey: ThemeProperty.backgroundImage)
        aCoder.encode(themeColor, forKey: ThemeProperty.themeColor)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let index = aDecoder.decodeInteger(forKey: ThemeProperty.index)
        guard let backgroundImage = aDecoder.decodeObject(forKey: ThemeProperty.backgroundImage) as? String else { return nil }
        guard let themeColor = aDecoder.decodeObject(forKey: ThemeProperty.themeColor) as? UIColor else { return nil }
        self.init(index: index, backgroundImage: backgroundImage, themeColor: themeColor)
    }
}

extension Theme {
    
    static func getCurrentTheme() -> Theme {
        return getCurrentThemeList()[0]
    }
    
    static func getCurrentThemeList() -> [Theme] {
        let themeKey = PreferenceTool.isMode(ofName: .NightMode) ? ThemeKey.DarkThemeKey : ThemeKey.LightThemeKey
        return getThemeList(ofKey: themeKey)
    }
    
    static func selectTheme(selectedTheme: Theme) {
        do {
            let themeKey = PreferenceTool.isMode(ofName: .NightMode) ? ThemeKey.DarkThemeKey : ThemeKey.LightThemeKey
            var themeList = getThemeList(ofKey: themeKey)
            let indexList = themeList.map({ $0.index })
            let index = indexList.firstIndex(of: selectedTheme.index)!
            themeList.swapAt(0, index)
            
            let url = getArchievePath(ofKey: themeKey)
            let data = try NSKeyedArchiver.archivedData(withRootObject: themeList, requiringSecureCoding: false)
            try data.write(to: url)
        } catch {
            return
        }
    }
    
    private static func getThemeList(ofKey themeKey: ThemeKey) -> [Theme] {
        do {
            let url = getArchievePath(ofKey: themeKey)
            let fileData = try Data(contentsOf: url)
            let result = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fileData)
            return result as? [Theme] ?? themeKey.getThemeList()
        } catch {
            return themeKey.getThemeList()
        }
    }
    
    private static func getArchievePath(ofKey themeKey: ThemeKey) -> URL {
        let url = Theme.BaseURL.appendingPathComponent(themeKey.rawValue)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: Theme.BaseURL.path) {
            try! fileManager.createDirectory(at: Theme.BaseURL, withIntermediateDirectories: true, attributes: nil)
        }
        if !fileManager.fileExists(atPath: url.path) {
            fileManager.createFile(atPath: url.path, contents: nil, attributes: nil)
        }
        return url
    }

}

