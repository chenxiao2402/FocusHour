//
//  AchievementVC.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/16.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class AchievementVC: UIViewController {

    
    @IBOutlet weak var yearSelector: YearSelector!
    @IBOutlet weak var titleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITool.setBackgroundImage(view, random: false)
        yearSelector.achievementVC = self
        titleButton.setTitle("\(TimeTool.getCurrentYear())", for: .normal)
        titleButton.addTarget(self, action: #selector(AchievementVC.displayYearSelector), for: .touchUpInside)
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func displayYearSelector() {
        yearSelector.yearButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func showAchievement(ofyear year: Int) {
        titleButton.setTitle("\(year)", for: .normal)
        displayYearSelector()
    }

}
