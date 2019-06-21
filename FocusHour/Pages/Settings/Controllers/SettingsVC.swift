//
//  PopoverViewController.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/11.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController{
   
    @IBOutlet weak var languageCell: SettingDetailCell!
    @IBOutlet weak var themeCell: SettingDetailCell!
    
    @IBOutlet weak var workingModeCell: NightModeSettingSwitchCell!
    @IBOutlet weak var nightModeCell: NightModeSettingSwitchCell!
    
    @IBOutlet weak var introductionCell: SettingDetailCell!
    @IBOutlet weak var developerCell: SettingDetailCell!
    @IBOutlet weak var versionCell: SettingDetailCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handleNightModeChange()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = LocalizationKey.Settings.translate()
        languageCell.keyVlue = .SetLanguage
        themeCell.keyVlue = .ChangeTheme
        workingModeCell.keyVlue = .WorkingMode
        nightModeCell.keyVlue = .NightMode
        introductionCell.keyVlue = .ThisApp
        developerCell.keyVlue = .Developer
        versionCell.keyVlue = .Version
        
        workingModeCell.mode = .WorkingMode
        nightModeCell.mode = .NightMode
        
        workingModeCell.tableViewController = self
        nightModeCell.tableViewController = self
        self.handleNightModeChange()
    }
    
    func handleNightModeChange(){
        UITool.setBackgroundImage(tableView, imageName: Theme.getCurrentTheme().backgroundImage)
        self.navigationController?.navigationBar.barTintColor = Theme.getCurrentTheme().themeColor
    }
    
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case SegueKey.ShowIntroduction.rawValue:
            guard let infoPresenter = segue.destination as? InfoPresenterVC else { return }
            infoPresenter.navTitle = LocalizationKey.ThisApp.translate()
            infoPresenter.info = LocalizationKey.Introduction.translate()
        default:
            return
        }
    }
}
