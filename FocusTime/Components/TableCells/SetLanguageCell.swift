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
    
    // cell被点击选择时的响应方法，更改cell的颜色，不要在设置cell的时候调用，会出现神奇的错误，参见SoundSelectorCell
    // 为了避免父类方法的变灰效果，用空函数复写
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    // 自定义的设置cell是否被选择（更改cell颜色和type）
    func setSelected(_ selected: Bool) {
        accessoryType = selected ? .checkmark : .none
    }
}
