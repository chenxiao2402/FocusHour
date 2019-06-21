//
//  TagTool.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/21.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class TagTool {
    
    static let tagListKey = "TagList"
    static let selectedTagKey = "SelectedTag"
    static let colorList = [#colorLiteral(red: 0.8549019608, green: 0.3647058824, blue: 0.3803921569, alpha: 1), #colorLiteral(red: 0.9725490196, green: 0.5490196078, blue: 0.5607843137, alpha: 1), #colorLiteral(red: 0.9176470588, green: 0.5764705882, blue: 0.2705882353, alpha: 1), #colorLiteral(red: 0.9921568627, green: 0.7647058824, blue: 0.337254902, alpha: 1), #colorLiteral(red: 0.9411764706, green: 0.8980392157, blue: 0.231372549, alpha: 1), #colorLiteral(red: 0.6, green: 0.7803921569, blue: 0.2196078431, alpha: 1), #colorLiteral(red: 0.3137254902, green: 0.7098039216, blue: 0.3058823529, alpha: 1), #colorLiteral(red: 0.4392156863, green: 0.8117647059, blue: 0.8470588235, alpha: 1), #colorLiteral(red: 0.2470588235, green: 0.6235294118, blue: 0.8784313725, alpha: 1), #colorLiteral(red: 0.6156862745, green: 0.4392156863, blue: 1, alpha: 1)]
    
    static func getTagList() -> [String] {
        guard let tagList = UserDefaults.standard.object(forKey: tagListKey) as? [String] else {
            UserDefaults.standard.set([LocalizationKey.Focus.translate()], forKey: tagListKey)
            UserDefaults.standard.set(LocalizationKey.Focus.translate(), forKey: selectedTagKey)
            return [LocalizationKey.Focus.translate()]
        }
        return tagList
    }
    
    static func addTag(name tag: String) -> Bool {
        let tagList = getTagList()
        if !tagList.contains(tag) {
            UserDefaults.standard.set(tagList + [tag], forKey: tagListKey)
            return true
        } else {
            return false
        }
    }
    
    static func selectTag(_ tag: String) {
        UserDefaults.standard.set(tag, forKey: selectedTagKey)
    }
    
    static func isSelectedTag(_ tag: String) -> Bool {
        guard let selectedTag = UserDefaults.standard.object(forKey: selectedTagKey) as? String else {
            UserDefaults.standard.set(getTagList()[0], forKey: selectedTagKey)
            return false
        }
        return selectedTag == tag
    }
    
    static func removeTag(name tagToRemove: String) -> Bool {
        var tagList = getTagList()
        if tagList.count > 1 {
            tagList.remove(at: tagList.firstIndex(of: tagToRemove)!)
            UserDefaults.standard.set(tagList, forKey: tagListKey)
            if isSelectedTag(tagToRemove) {
                selectTag(tagList[0])
            }
            return true
        } else {
            return false
        }
    }
    
    static func getColor(ofIndex index: Int) -> UIColor {
        return colorList[index % colorList.count]
    }
    
}
