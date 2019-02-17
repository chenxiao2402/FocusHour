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
        
       
//        titleButton = UIButton.init(type: .system)
//        titleButton.tintColor = UIColor.white
//        titleButton.backgroundColor = UIColor.blue
//        titleButton.titleLabel?.font = UIFont(name: "Verdana", size: 20)
//        titleButton.frame = CGRect(x: 0, y: 0, width: 120, height: 32)
//        titleButton.setTitle("My title", for: .normal)
//        titleButton.setImage(UIImage(named: "arrow-down"), for: .normal)
        titleButton.addTarget(self, action: #selector(AchievementVC.displayYearSelector), for: .touchUpInside)
//        let titleSize = titleButton.titleLabel?.bounds.size;
//        let imageSize = titleButton.imageView?.bounds.size;
//        let interval: CGFloat = 1.0;
//
//        print("的手机卡的撒")
//        print(titleSize)
//        print(imageSize)
//
//        titleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 90, bottom: 0, right: -90)
//        titleButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageSize!.width + interval), bottom: 0, right: imageSize!.width + interval);
//
//
//        self.navigationItem.titleView = titleButton;
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
