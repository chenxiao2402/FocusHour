//
//  TableCell.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/11.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    var keyVlue: String! {
        didSet {
            setLabelText()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = ColorEnum.getColor(name: .LightYellow)
    }
    
    private func setLabelText() {
        label.text = NSLocalizedString(keyVlue, comment: "")
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
             self.backgroundColor = ColorEnum.getColor(name: .LightGreen)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.backgroundColor = ColorEnum.getColor(name: .PaleGreen)
        }
    }

}
