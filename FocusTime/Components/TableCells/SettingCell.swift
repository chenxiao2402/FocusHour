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
    
    var keyVlue: SettingEnum! {
        didSet {
            label.text = keyVlue.translate()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        label.textColor = UIColor.white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
}
