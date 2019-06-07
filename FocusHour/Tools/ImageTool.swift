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
    
    static func getTableDrivenImage(ofTime time: Int, timeRange: [Int], imageList: [String]) -> String {
        var imageName = imageList[0]
        for (i, timeBoundry) in timeRange.enumerated() {
            if (time >= timeBoundry) {
                imageName = imageList[i]
            }
        }
        return imageName
    }
}
