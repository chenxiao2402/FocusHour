//
//  SetTimeViewController.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/4.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SetTimeVC: ViewController {
    
    @IBOutlet weak var timeSetter: CircleSlider!
    @IBOutlet weak var startButton: StartButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITool.setToolButtonSize(settingsButton, ratio: 1.0)
        UITool.setBackgroundImage(self.view, random: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startButton.setTitle(LocalizationKey.Start.translate(), for: .normal)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case SegueEnum.ShowTimer.rawValue:
            guard let timeConterController = segue.destination as? TimerVC else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            let totalFocusTime = timeSetter.remainingMinutes * 60
            let background = view.backgroundColor
            timeConterController.view.backgroundColor = background
            timeConterController.circleTimer.remainingTime = totalFocusTime
        case SegueEnum.ShowSettings.rawValue:
            return
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "")")
        }
    }
}
