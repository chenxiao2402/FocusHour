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
    @IBOutlet weak var phraseCell: SettingDetailCell!
    @IBOutlet weak var themaCell: SettingDetailCell!
    
    @IBOutlet weak var workingModeCell: NightModeSettingSwitchCell!
    @IBOutlet weak var nightModeCell: NightModeSettingSwitchCell!
    
    @IBOutlet weak var introductionCell: SettingDetailCell!
    @IBOutlet weak var aboutCell: SettingDetailCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handleNightModeChange();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = LocalizationKey.Settings.translate()
        languageCell.keyVlue = LocalizationKey.SetLanguage
        phraseCell.keyVlue = LocalizationKey.SetPhrase
        themaCell.keyVlue = LocalizationKey.ChangeThema
        workingModeCell.keyVlue = LocalizationKey.WorkingMode
        nightModeCell.keyVlue = LocalizationKey.NightMode
        introductionCell.keyVlue = LocalizationKey.ThisApp
        aboutCell.keyVlue = LocalizationKey.About
        
        workingModeCell.mode = .WorkingMode
        nightModeCell.mode = .NightMode
        
        nightModeCell.tableViewController = self;
        self.handleNightModeChange();
    }
    
    func handleNightModeChange(){
        UITool.setBackgroundImage(tableView, imageName: ThemeTool.getCurrentTheme().backgroundImageName);
        self.navigationController?.navigationBar.barTintColor = UIColor.ColorHex(hex: ThemeTool.getCurrentTheme().navigationColor)
        let nightMode = UserDefaults.standard.bool(forKey: "NightMode");
        let labelTextColor = nightMode == true ? UIColor.white : UIColor.black;
        
        languageCell.label?.textColor = labelTextColor;
        phraseCell.label?.textColor = labelTextColor;
        themaCell.label?.textColor = labelTextColor;
        workingModeCell.label?.textColor = labelTextColor;
        nightModeCell.label?.textColor = labelTextColor;
        introductionCell.label?.textColor = labelTextColor;
        aboutCell.label?.textColor = labelTextColor;
    
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
        case SegueKey.ShowAboutInfo.rawValue:
            guard let infoPresenter = segue.destination as? InfoPresenterVC else { return }
            infoPresenter.navTitle = LocalizationKey.About.translate()
            infoPresenter.info = LocalizationKey.AboutUs.translate()
        default:
            return
        }
    }
}
