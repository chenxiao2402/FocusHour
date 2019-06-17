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
        themeCells = Theme.getCurrentThemeList().sorted(by: { $0.index < $1.index })
        navigationItem.title = LocalizationKey.ChangeTheme.translate()
        
        UITool.setBackgroundImage(view, imageName: Theme.getCurrentTheme().backgroundImage)
        self.navigationController?.navigationBar.barTintColor = Theme.getCurrentTheme().themeColor
        
    }
    
    func handleThemeChange(newTheme: Theme) {
        UITool.setBackgroundImage(view, imageName: newTheme.backgroundImage)
        self.navigationController?.navigationBar.barTintColor = Theme.getCurrentTheme().themeColor
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themeCells.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightRatio = CGFloat(UIDevice().model == "iPad" ? 1.0 / 5.0 : 1.0 / 4.0)
        return heightRatio * UIScreen.main.bounds.height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath) as! ThemeCell
        cell.theme = themeCells[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let theme = themeCells[indexPath.row]
        Theme.selectTheme(selectedTheme: theme)
        handleThemeChange(newTheme: theme)
    }
}
