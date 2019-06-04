//
//  SoundSelectorCell.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/11.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SoundSelectorCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    var sound: SoundKey! {
        didSet {
            label.text = sound.translate()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        label.textColor = ColorKey.DimGray.uiColor()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
             backgroundColor = ColorKey.LightGreen.uiColor()
        }
    }
    
    // cell被点击选择时的响应方法，更改cell的颜色，不要在设置cell的时候调用，会出现神奇的错误，参见一堆注释
    // 为了避免父类方法的变灰效果，用空函数复写
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    // 自定义的设置cell是否被选择（更改cell颜色和type）
    func setSelected(_ selected: Bool) {
        accessoryType = selected ? .checkmark : .none
        backgroundColor = selected ? ColorKey.PaleGreen.uiColor() : UIColor.clear
    }
    
    /*
     复写了父类中点击选择cell时的方法
     虽然在加载完之后点击，这个方法可以正常设置cell状态
     
     但是如果在初始化时生成cell的 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     中调用这个方法的话，就会变成：
     
     如果删去else语句块，这个方法就会按照是否selected正常响应，如果selected就会有改变，没有被selected就什么都不做
     但是如果添加上else语句块，那么无论是否selected，都会调用else中的设置，而不是条件判断
     WTF
     
     当然，显然不应该在初始化的时候调用这个方法，所以改成下面的自定义方法了
     
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            accessoryType = .checkmark
            backgroundColor = ColorKey.PaleGreen.getColor()
        } else {
            accessoryType = .detailButton
            backgroundColor = UIColor.clear
        }
    }
    */
}
