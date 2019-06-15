//
//  ThemeVC.swift
//  FocusHour
//
//  Created by 賴健明 on 2019/6/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class ThemeVC: UITableViewController{
    
    var themeCells : [Theme] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        let nightMode = UserDefaults.standard.bool(forKey: "NightMode");
        if nightMode == true{
            themeCells = ThemeKey.getDarkTheme();
        }else{
            themeCells = ThemeKey.getLightTheme();
        }
        navigationItem.title = LocalizationKey.ChangeThema.translate();
        
        UITool.setBackgroundImage(view, imageName: ThemeTool.getCurrentTheme().backgroundImageName);
        self.navigationController?.navigationBar.barTintColor = UIColor.ColorHex(hex: ThemeTool.getCurrentTheme().navigationColor)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func handleThemeChange(newTheme: Theme)->Void{
        UITool.setBackgroundImage(view, imageName: ThemeTool.getCurrentTheme().backgroundImageName);
        self.navigationController?.navigationBar.barTintColor = UIColor.ColorHex(hex: ThemeTool.getCurrentTheme().navigationColor)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themeCells.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath) as! ThemeCell
        cell.theme = themeCells[indexPath.row];
        cell.controller = self;
        return cell
    }
}
