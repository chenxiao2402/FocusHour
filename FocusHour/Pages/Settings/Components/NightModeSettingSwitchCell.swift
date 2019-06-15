//
//  NightModeSettingSwitchCell.swift
//  FocusHour
//
//  Created by 賴健明 on 2019/6/12.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class NightModeSettingSwitchCell: SettingSwitchCell {
    
    
    @IBAction override func SwitchMode(_ sender: Any) {
        super.SwitchMode(sender);
        let nightMode = ModeTool.isMode(ofName: self.mode);
        UserDefaults.standard.set(nightMode, forKey: "NightMode");
        let changeTo = nightMode == true ? ThemeKey.getDarkTheme()[0] : ThemeKey.getLightTheme()[0];
        ThemeTool.changeTheme(theme: changeTo);
        (self.tableViewController as! SettingsVC).handleNightModeChange();
    }
    
}
