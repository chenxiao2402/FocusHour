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
    var titleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //定义渐变的颜色（从黄色渐变到橙色）
        let topColor = #colorLiteral(red: 0.2509803922, green: 0.5294117647, blue: 0.3137254902, alpha: 1)
        let buttomColor = #colorLiteral(red: 0.1137254902, green: 0.1882352941, blue: 0.1882352941, alpha: 1)
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = self.view.frame
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        //UITool.setBackgroundImage(view, random: false)
        yearSelector.achievementVC = self
        
        titleButton = UIButton.init(type: .system)
        titleButton.tintColor = UIColor.white
        titleButton.titleLabel?.font = UIFont(name: "Verdana", size: 20)
        titleButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        titleButton.setTitle("My title ▼", for: .normal)
        titleButton.addTarget(self, action: #selector(AchievementVC.layoutYearSelector), for: .touchDown)
        self.navigationItem.titleView = titleButton;
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func layoutYearSelector() {
        yearSelector.yearButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func showAchievement(ofyear year: Int) {
        titleButton.setTitle("\(year) ▼", for: .normal)
        layoutYearSelector()
    }

}
