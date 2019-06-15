//
//  SetTimeViewController.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/4.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SetTimeVC: UIViewController {
    
    @IBOutlet weak var timeSetter: CircleSlider!
    @IBOutlet weak var startButton: StartButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var achievementButton: UIButton!
    @IBOutlet weak var coinLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("1000", forKey: "coins");
        UITool.setToolButtonSize(achievementButton, ratio: 1.0)
        UITool.setToolButtonSize(settingsButton, ratio: 1.0)
        UITool.setBackgroundImage(self.view, random: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // timeSetter.drawHeadLabel(LocalizationKey.NotificationDeath.translate())
        // 如果调用上面那个方法会出现label只画出左边70%左右的情况，可能是因为viewWillAppear的时候获得的高度还是不保证准确的
        timeSetter.headLabel.text = LocalizationKey.SetTimeTitle.translate()
        startButton.setTitle(LocalizationKey.Start.translate(), for: .normal)
        
        let coins = UserDefaults.standard.integer(forKey: "Coins");
        
        coinLabel.text = String(coins);
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case SegueKey.ShowTimer.rawValue:
            guard let timerVC = segue.destination as? TimerVC else { return }
            let totalFocusHour = timeSetter.remainingMinutes * 60
            let background = view.backgroundColor
            timerVC.view.backgroundColor = background
            timerVC.circleTimer.remainingTime = totalFocusHour
        default:
            return
        }
    }
}
