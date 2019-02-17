//
//  YearSelector.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/16.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class YearSelector: UIStackView {


    //MARK: Properties
    
    @IBInspectable var buttonSize: CGSize = CGSize(width: 300, height: 50)
    let years = PlantRecord.getRecordYears()
    var yearButtons: [UIButton] = []
    var achievementVC: AchievementVC!

    
    //MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }

    
    //MARK: Private Methods

    private func setupButtons() {
        for button in yearButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        yearButtons.removeAll()

        for year in PlantRecord.getRecordYears() {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
            button.layer.borderWidth = 0.8
            button.layer.borderColor = UIColor.white.cgColor
            button.backgroundColor = ColorEnum.getColor(name: .DarkSlateGray)
            button.titleLabel?.font = UIFont(name: "Verdana", size: 20)
            button.isHidden = true
            button.setTitle("\(year)", for: .normal)
            button.addTarget(self, action: #selector(YearSelector.handleSelection(button:)), for: .touchUpInside)

            addArrangedSubview(button)
            yearButtons.append(button)
        }
    }
    
    @objc func handleSelection(button: UIButton) {
        let year = Int(button.titleLabel?.text ?? "0")!
        achievementVC.showAchievement(ofyear: year)
    }
}
