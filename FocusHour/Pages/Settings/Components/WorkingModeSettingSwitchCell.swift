//
//  WorkingModeSettingSwitchCell.swift
//  FocusHour
//
//  Created by 賴健明 on 2019/6/12.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class WorkingModeSettingSwitchCell: SettingSwitchCell {
    
    
    @IBAction override func SwitchMode(_ sender: Any) {
        super.SwitchMode(sender)
        if PreferenceTool.isMode(ofName: mode) {
            let alertController = UIAlertController(title: LocalizationKey.WorkingMode.translate(), message: LocalizationKey.WorkingModeInfo.translate(), preferredStyle: .alert)
            let alertAction = UIAlertAction(title: LocalizationKey.Yes.translate(), style: .default, handler: nil)
            alertController.addAction(alertAction)
            tableViewController.present(alertController, animated: true, completion: nil)
        }
    }
    
}

