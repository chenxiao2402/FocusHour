//
//  SetLanguageCell.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/12.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SetLanguageCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    var language: LanguageEnum! {
        didSet {
            label.text = language.getName()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        label.textColor = UIColor.white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        accessoryType = selected ? .checkmark : .none
    }
}
