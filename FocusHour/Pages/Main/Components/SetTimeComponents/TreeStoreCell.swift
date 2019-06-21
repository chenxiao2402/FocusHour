
//
//  TreeStoreCell.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/17.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class TreeStoreCell: UITableViewCell {

    @IBOutlet weak var selectedIcon: UIImageView!
    @IBOutlet weak var treeSeriesIcon: UIImageView!
    @IBOutlet weak var priceLabelContainer: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    
    var treeSeries: TreeSeries! {
        didSet {
            treeSeriesIcon.image = UIImage(named: "\(treeSeries.name)-5")
            selectedIcon.isHidden = treeSeries.state != TreeSeriesState.Selected.rawValue
            priceLabelContainer.isHidden = treeSeries.state != TreeSeriesState.OnSale.rawValue
            priceLabel.text = "\(treeSeries.price)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}

}
