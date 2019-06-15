//
//  ThemeCell.swift
//  FocusHour
//
//  Created by 賴健明 on 2019/6/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {

    var theme: Theme! {
        didSet {
            themeNameLabel.text = "\(theme.index)"
            themeImageView.image = UIImage(named: theme.backgroundImage)
        }
    }
    
    @IBOutlet weak var themeImageView: UIImageView!
    @IBOutlet weak var themeNameLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
}
