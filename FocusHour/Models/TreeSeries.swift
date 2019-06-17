//
//  TreeSeries.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/17.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

enum TreeSeriesName: String {
    case AppleTree = "AppleTree"
    case SquareTree = "SquareTree"
    case Bush = "Bush"
    case MorningGlory = "MorningGlory"
}

enum TreeSeriesState {
    case Selected
    case Owned
    case OnSale
}

struct TreeSeriesProperty {
    static let name = "TreeSeriesName"
    static let state = "TreeSeriesState"
    static let price = "TreeSeriesPrice"
}

class TreeSeries: NSObject, NSCoding {
    
    static let BaseURL = SystemConstant.DocumentsDirectory.appendingPathComponent("Series")
    static let defaultList = [
        TreeSeries(name: .AppleTree, state: .Selected, price: 0),
        TreeSeries(name: .SquareTree, state: .OnSale, price: 400),
        TreeSeries(name: .MorningGlory, state: .OnSale, price: 800),
        TreeSeries(name: .Bush, state: .OnSale, price: 1200),
    ]
    
    let name: TreeSeriesName
    let state: TreeSeriesState
    let price: Int
    
    init(name: TreeSeriesName, state: TreeSeriesState, price: Int) {
        self.name = name
        self.state = state
        self.price = price
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: TreeSeriesProperty.name)
        aCoder.encode(state, forKey: TreeSeriesProperty.state)
        aCoder.encode(price, forKey: TreeSeriesProperty.price)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: TreeSeriesProperty.name) as? TreeSeriesName else { return nil }
        guard let state = aDecoder.decodeObject(forKey: TreeSeriesProperty.state) as? TreeSeriesState else { return nil }
        let price = aDecoder.decodeInteger(forKey: TreeSeriesProperty.price)
        self.init(name: name, state: state, price: price)
    }
}

extension TreeSeries {
    
    static func getCurrentTreeSeries() -> Theme {
        return getCurrentThemeList()[0]
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
    
    static func getTreeSeriesList() -> [TreeSeries] {
        do {
            let url = getArchievePath(ofKey: themeKey)
            let fileData = try Data(contentsOf: url)
            let result = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fileData)
            return result as? [Theme] ?? themeKey.getThemeList()
        } catch {
            return themeKey.getThemeList()
        }
    }
    
    private static func getArchievePath() -> URL {
        let url = TreeSeries.BaseURL.appendingPathComponent("record")
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: TreeSeries.BaseURL.path) {
            try! fileManager.createDirectory(at: TreeSeries.BaseURL, withIntermediateDirectories: true, attributes: nil)
        }
        if !fileManager.fileExists(atPath: url.path) {
            fileManager.createFile(atPath: url.path, contents: nil, attributes: nil)
        }
        return url
    }
    
}


