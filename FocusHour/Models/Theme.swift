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
        Theme(index: 1, backgroundImage: "background-dark-0", navigationColor: "#B636B46"),
        Theme(index: 2, backgroundImage: "background-dark-1", navigationColor: "#494E6B"),
        Theme(index: 3, backgroundImage: "background-dark-2", navigationColor: "#414141"),
        Theme(index: 4, backgroundImage: "background-dark-3", navigationColor: "#22252C"),
        Theme(index: 5, backgroundImage: "background-dark-4", navigationColor: "#333A56"),
    ]
    
    static let defaultLightThemeList: [Theme] = [
        // light theme
        Theme(index: 1, backgroundImage: "background-light-0", navigationColor: "#B37D4E"),
        Theme(index: 2, backgroundImage: "background-light-1", navigationColor: "#30415D"),
        Theme(index: 3, backgroundImage: "background-light-2", navigationColor: "#000000"),
        Theme(index: 4, backgroundImage: "background-light-3", navigationColor: "#6C648B"),
        Theme(index: 5, backgroundImage: "background-light-4", navigationColor: "E626E60"),
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
    static let navigationColor = "navigationColor"
}

class Theme: NSObject, NSCoding {
    
    static let BaseURL = SystemConstant.DocumentsDirectory.appendingPathComponent("Themes")
    
    let index: Int
    let backgroundImage: String
    let navigationColor: String
    
    init(index: Int, backgroundImage: String, navigationColor: String) {
        self.index = index
        self.backgroundImage = backgroundImage
        self.navigationColor = navigationColor
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(index, forKey: ThemeProperty.index)
        aCoder.encode(backgroundImage, forKey: ThemeProperty.backgroundImage)
        aCoder.encode(navigationColor, forKey: ThemeProperty.navigationColor)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let index = aDecoder.decodeInteger(forKey: ThemeProperty.index)
        guard let backgroundImage = aDecoder.decodeObject(forKey: ThemeProperty.backgroundImage) as? String else { return nil }
        guard let navigationColor = aDecoder.decodeObject(forKey: ThemeProperty.navigationColor) as? String else { return nil }
        self.init(index: index, backgroundImage: backgroundImage, navigationColor: navigationColor)
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

