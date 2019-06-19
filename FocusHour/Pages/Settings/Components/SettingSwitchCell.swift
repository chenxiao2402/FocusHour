//
//  SettingSwitchCell.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/4.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SettingSwitchCell: SettingDetailCell {
    
    var tableViewController: UITableViewController!
    
    @IBOutlet weak var modeSwitch: UISwitch!
    var mode: AppMode! {
        didSet {
            modeSwitch.isOn = PreferenceTool.isMode(ofName: mode)
        }
    }
    
    @IBAction func SwitchMode(_ sender: Any) {
        PreferenceTool.switchMode(ofName: mode)
    }
}
