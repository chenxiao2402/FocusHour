//
//  ImageTool.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/7.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class ImageTool {
    
    static func getBackgroundImage(random: Bool) -> UIImage? {
        if !random {
            return UIImage(named: "base-background")
        } else {
            let index = Int.random(in: 0..<8)
            return UIImage(named: "background-\(index)")
        }
    }
    
    
    static func getBackgroundImageInDark() -> UIImage? {
        return UIImage(named: "background-dark-5")
    }
    
    static func getBackgroundImageInLight() -> UIImage? {
        return UIImage(named: "background-light-5")
    }
    
    
    static func getTableDrivenImage(ofTime time: Int, timeRange: [Int], imageList: [String]) -> String {
        return imageList[getIndex(focusMinutes: time, timeRange: timeRange)]
    }
    
    static func getIndex(focusMinutes: Int, timeRange: [Int]) -> Int {
        var index = 0
        for (i, timeBoundry) in timeRange.enumerated() {
            if (focusMinutes >= timeBoundry) {
                index = i
            } else {
                break
            }
        }
        return index
    }
}
