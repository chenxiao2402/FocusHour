//
//  PopoverViewController.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/11.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {
    
    @IBOutlet weak var setLanguageCell: SettingCell!
    @IBOutlet weak var aboutInfoCell: SettingCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITool.setBackgroundImage(self.view, random: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = SettingEnum.Settings.translate()
        setLanguageCell.keyVlue = SettingEnum.SetLanguage
        aboutInfoCell.keyVlue = SettingEnum.About
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
