//
//  ThemeCell.swift
//  FocusHour
//
//  Created by 賴健明 on 2019/6/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {

    @IBOutlet weak var themeImageView: ThemeImageView!
    @IBOutlet weak var themeNameLabel: UILabel!
    
    var theme: Theme! {
        didSet {
            themeNameLabel.text = theme.name
            themeImageView.image = UIImage(named: theme.backgroundImage)
        }
    }
    
    override func awakeFromNib() {
        themeImageView.contentMode = .scaleAspectFill
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
}
