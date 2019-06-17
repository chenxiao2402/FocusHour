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

enum TreeSeriesState: Int {
    case OnSale = 0
    case Owned = 1
    case Selected = 2
}

struct TreeSeriesProperty {
    static let name = "TreeSeriesName"
    static let state = "TreeSeriesState"
    static let price = "TreeSeriesPrice"
}

class TreeSeries: NSObject, NSCoding {
    
    static let BaseURL = SystemConstant.DocumentsDirectory.appendingPathComponent("Series")
    static let defaultList = [
        TreeSeries(seriesName: .AppleTree, seriesState: .Selected, price: 0),
        TreeSeries(seriesName: .SquareTree, seriesState: .OnSale, price: 400),
        TreeSeries(seriesName: .MorningGlory, seriesState: .OnSale, price: 800),
        TreeSeries(seriesName: .Bush, seriesState: .OnSale, price: 1200),
    ]
    
    let name: String
    let price: Int
    var state: Int
    
    private init(seriesName: TreeSeriesName, seriesState: TreeSeriesState, price: Int) {
        self.name = seriesName.rawValue
        self.state = seriesState.rawValue
        self.price = price
    }
    
    private init(name: String, state: Int, price: Int) {
        self.name = name
        self.state = state
        self.price = price
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: TreeSeriesProperty.name)
        aCoder.encode(price, forKey: TreeSeriesProperty.price)
        aCoder.encode(state, forKey: TreeSeriesProperty.state)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: TreeSeriesProperty.name) as? String else { return nil }
        let state = aDecoder.decodeInteger(forKey: TreeSeriesProperty.state)
        let price = aDecoder.decodeInteger(forKey: TreeSeriesProperty.price)
        self.init(name: name, state: state, price: price)
    }
}

extension TreeSeries {
    
    static func getCurrentTreeSeries() -> TreeSeries {
        let treeSeriesList = getTreeSeriesList()
        for treeSeries in treeSeriesList {
            if treeSeries.state == TreeSeriesState.Selected.rawValue {
                return treeSeries
            }
        }
        return defaultList[0]
    }
    
    static func selectTreeSeries(_ selectedSeries: TreeSeries) {
        do {
            let treeSeriesList = getTreeSeriesList()
            for treeSeries in treeSeriesList {
                if treeSeries.name == selectedSeries.name {
                    treeSeries.state = TreeSeriesState.Selected.rawValue
                } else if treeSeries.state == TreeSeriesState.Selected.rawValue {
                    treeSeries.state = TreeSeriesState.Owned.rawValue
                }
            }
            
            let url = getArchievePath()
            let data = try NSKeyedArchiver.archivedData(withRootObject: treeSeriesList, requiringSecureCoding: false)
            try data.write(to: url)
        } catch {
            return
        }
    }
    
    static func getTreeSeriesList() -> [TreeSeries] {
        do {
            let url = getArchievePath()
            let fileData = try Data(contentsOf: url)
            let result = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fileData)
            return result as? [TreeSeries] ?? defaultList
        } catch {
            return defaultList
        }
    }
    
    private static func getArchievePath() -> URL {
        let url = TreeSeries.BaseURL.appendingPathComponent("record")
        print(url.path)
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


