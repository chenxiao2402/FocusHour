//
//  ThemeTool.swift
//  FocusHour
//
//  Created by 賴健明 on 2019/6/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation


class ThemeTool {
    
    static func getCurrentTheme() -> Theme {
        let theme = UserDefaults.standard.object(forKey: "Theme") as? [String];
        let nightMode = UserDefaults.standard.bool(forKey: "NightMode");
        if theme == nil{
            let defaultTheme = nightMode == true ? ThemeKey.getDefaultDarkTheme() : ThemeKey.getDefaultLightTheme();
            ThemeTool.changeTheme(theme: defaultTheme);
        }
        return Theme(name: theme![0], backgroundImageName: theme![1], navigationColor: theme![2]);
        
    }
    
    static func changeTheme(theme: Theme) -> Void{
        UserDefaults.standard.removeObject(forKey: "Theme");
        UserDefaults.standard.set(theme.toList(), forKey: "Theme");
        
    }
}
