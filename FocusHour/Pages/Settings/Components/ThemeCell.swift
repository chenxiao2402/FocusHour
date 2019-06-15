//
//  ThemeCell.swift
//  FocusHour
//
//  Created by 賴健明 on 2019/6/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {
    
    var controller: ThemeVC!;
    
    var theme: Theme! {
        didSet {
            themeNameLabel.text = theme.name
            themeImageView.image = UIImage(named: theme.backgroundImageName)
        }
    }
    
    @IBOutlet weak var themeImageView: UIImageView!
    
    @IBOutlet weak var themeNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        ThemeTool.changeTheme(theme: theme);
        controller.handleThemeChange(newTheme: theme);
    }
    
}
