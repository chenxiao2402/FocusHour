//
//  ThemeKey.swift
//  FocusHour
//
//  Created by 賴健明 on 2019/6/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

struct Theme {
    let name: String
    let backgroundImageName: String
    let navigationColor: String
    
    func toTuple() -> (String, String, String){
        return (name, backgroundImageName, navigationColor);
    }
    
    func toList() -> [String] {
        return [name, backgroundImageName, navigationColor];
    }
}

class ThemeKey{
    static let darkThemeList : [Theme] = [
        // dark theme
        Theme(name: "主題一", backgroundImageName: "background-dark-0", navigationColor: "#B636B46"),
        Theme(name: "主題二", backgroundImageName: "background-dark-1", navigationColor: "#494E6B"),
        Theme(name: "主題三", backgroundImageName: "background-dark-2", navigationColor: "#414141"),
        Theme(name: "主題四", backgroundImageName: "background-dark-3", navigationColor: "#22252C"),
        Theme(name: "主題五", backgroundImageName: "background-dark-4", navigationColor: "#333A56"),
    ]
    
    static let lightThemeList: [Theme] = [
        // light theme
        Theme(name: "主題一", backgroundImageName: "background-light-0", navigationColor: "#B37D4E"),
        Theme(name: "主題二", backgroundImageName: "background-light-1", navigationColor: "#30415D"),
        Theme(name: "主題三", backgroundImageName: "background-light-2", navigationColor: "#000000"),
        Theme(name: "主題四", backgroundImageName: "background-light-3", navigationColor: "#6C648B"),
        Theme(name: "主題五", backgroundImageName: "background-light-4", navigationColor: "E626E60"),
    ]
    
    static func getDarkTheme()->[Theme] {
        return self.darkThemeList
    }
    
    static func getLightTheme() -> [Theme] {
        return self.lightThemeList;
    }
    
    static func getDefaultDarkTheme() -> Theme{
        return darkThemeList[0];
    }
    
    static func getDefaultLightTheme() -> Theme{
        return lightThemeList[0];
    }
    
}

