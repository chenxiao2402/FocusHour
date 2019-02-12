//
//  PopoverViewController.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/11.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {
    
    var settings: [SettingEnum] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        UITool.setBackgroundImage(view, random: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        self.navigationItem.title = NSLocalizedString(SettingEnum.Settings.rawValue, comment: "")
        self.navigationController?.navigationBar.barTintColor = ColorEnum.getColor(name: .ForestGreen)
        settings = SettingEnum.getKeyList()
    }
    
    @IBAction func quit(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        cell.keyVlue = settings[indexPath.row].rawValue
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! BasticTableCell
//    }
}
