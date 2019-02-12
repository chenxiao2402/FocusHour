//
//  SoundSelectorCell.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/11.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SoundSelectorCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    var sound: SoundEnum! {
        didSet {
            label.text = sound.translate()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        label.textColor = ColorEnum.getColor(name: .DimGray)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
             backgroundColor = ColorEnum.getColor(name: .LightGreen)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            accessoryType = .checkmark
            backgroundColor = ColorEnum.getColor(name: .PaleGreen)
        }
    }
}
