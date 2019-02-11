//
//  TimeCounterController.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/9.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class TimerVC: ViewController {

    let soundPlayer: SoundPlayer = SoundPlayer()
    var timer: Timer!
    @IBOutlet weak var circleTimer: CircleTimer!
    @IBOutlet weak var stopButton: StopButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITool.setToolButtonSize(returnButton, ratio: 432.0 / 512.0)
        UITool.setToolButtonSize(soundButton, ratio: 1.0)
        setSoundButtonStyle()
        
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
    
    func setSoundButtonStyle() {
        let soundOn: Bool = soundPlayer.soundKey != .None
        soundButton.setImage(UIImage(named: soundOn ? "sound-on" : "sound-off"), for: .normal)
    }
    
    @IBAction func StopButtonTapped(_ sender: Any) {
        let alert = UIAlertController(
            title: NSLocalizedString("GiveupAlert-Title", comment: ""),
            message: NSLocalizedString("GiveupAlert-DeathMessage", comment: ""),
            preferredStyle: .alert
        )
        alert.addAction(.init(
            title: NSLocalizedString("Cancel", comment: ""),
            style: .cancel
        ))
        alert.addAction(.init(
            title: NSLocalizedString("Yes", comment: ""),
            style: .destructive,
            handler: { (_) in
                self.timer.invalidate()
                self.returnButton.isEnabled = true
                self.soundPlayer.stop()
                self.setSoundButtonStyle()
        }))
        present(alert, animated: true, completion: nil)
        
//        let languages: NSArray = UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray
//        print("切换之前: \(languages)")
//
//        // 切换语言
//        let newLanguages: NSArray = ["zh-Hans", "ja", "en"]
//        UserDefaults.standard.set(newLanguages, forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//        Bundle.main.onLanguage()
//        stopButton.setButtonStyle()
    }
    
    @IBAction func returnToMainpage(_ sender: Any) {
        soundPlayer.invalidate()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showMusicSelector(_ sender: Any) {
        guard let soundSelector = storyboard?.instantiateViewController(withIdentifier: "SoundSelector") as? SoundSelectorVC else { return }
        soundSelector.modalPresentationStyle = .popover
        soundSelector.preferredContentSize = CGSize(width: 240, height: 280)
        soundSelector.timerVC = self
        let popoverController = soundSelector.popoverPresentationController
        popoverController?.delegate = self
        popoverController?.sourceView = self.soundButton
        popoverController?.sourceRect = soundButton.bounds
        self.present(soundSelector, animated: true)
    }
    
}

extension TimerVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
