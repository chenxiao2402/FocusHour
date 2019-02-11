//
//  TimeCounterController.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/9.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class TimeCounterController: ViewController {

    var timer: Timer!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var circleTimer: CircleTimer!
    @IBOutlet weak var stopButton: StopButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITool.setToolButtonSize(returnButton, ratio: 432.0 / 512.0)
        UITool.setToolButtonSize(musicButton, ratio: 1.0)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
            if self.circleTimer.remainingTime > 0 {
                self.circleTimer.resetTime()
                if (self.circleTimer.focusTime > 10) {
                    self.returnButton.isEnabled = false
                }
            } else {
                self.timer.invalidate()
                self.returnButton.isEnabled = true
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        stopButton.setTitle(NSLocalizedString("Giveup", comment: ""), for: .normal)
    }
    
    @IBAction func StopButtonTapped(_ sender: Any) {
//        let alert = UIAlertController(
//            title: NSLocalizedString("GiveupAlert-Title", comment: ""),
//            message: NSLocalizedString("GiveupAlert-DeathMessage", comment: ""),
//            preferredStyle: .alert
//        )
//        alert.addAction(.init(
//            title: NSLocalizedString("Cancel", comment: ""),
//            style: .cancel
//        ))
//        alert.addAction(.init(
//            title: NSLocalizedString("Yes", comment: ""),
//            style: .destructive,
//            handler: { (_) in
//                self.timer.invalidate()
//                self.returnButton.isEnabled = true
//        }))
//        present(alert, animated: true, completion: nil)
        
        let languages: NSArray = UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray
        print("切换之前: \(languages)")
        
        // 切换语言
        let newLanguages: NSArray = ["zh-Hans", "ja", "en"]
        UserDefaults.standard.set(newLanguages, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        Bundle.main.onLanguage()
        stopButton.setButtonStyle()
    }
    
    @IBAction func returnToMainpage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
