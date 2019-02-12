//
//  SettingCell.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/12.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    var keyVlue: String! {
        didSet {
            label.text = NSLocalizedString(keyVlue, comment: "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        label.textColor = UIColor.white
    }
    
}
