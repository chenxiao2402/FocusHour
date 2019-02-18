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
import UserNotifications

class TimerVC: ViewController {
    
    let soundPlayer: SoundPlayer = SoundPlayer()
    let backgroundTimeLimit: Int = 10
    let cancelableTimeLimit: Int = 10
    private var mainTimer: Timer!
    private var cancelable: Bool = true
    private var backgroundObserver: NSObjectProtocol?
    private var returnObserver: NSObjectProtocol?
    private var backgroundTimer: Timer!
    private var backgroundTime: Int!
    
    @IBOutlet weak var circleTimer: CircleTimer!
    @IBOutlet weak var stopButton: StopButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundTime = backgroundTimeLimit
        UITool.setToolButtonSize(returnButton, ratio: 432.0 / 512.0)
        UITool.setToolButtonSize(soundButton, ratio: 1.0)
        setSoundButtonStyle()
        setStopButtonTitle()
        returnButton.isEnabled = false
        
        mainTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
            if self.circleTimer.remainingTime > 0 {
                self.circleTimer.resetTime()
                self.cancelable = self.circleTimer.focusTime <= self.cancelableTimeLimit
                self.setStopButtonTitle()
            } else {
                self.end()
            }
        })
        
        backgroundObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: UIApplication.shared,
            queue: OperationQueue.main,
            using: { _ in
                if !UITool.isScreenLocked() {
                    self.backgroundCountdown()
                }
        })
        
        returnObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: UIApplication.shared,
            queue: OperationQueue.main,
            using: { _ in
                self.returnFromBackground()
        })
    }
    
    @IBAction func StopButtonTapped(_ sender: Any) {
        print(PlantRecord.loadRecords(year: 2019, month: 2))
        let meal = PlantRecord(imgName: "图片名", minute: 233, year: 2019, month: 2, day: 4)
        meal?.save()
        print(PlantRecord.loadRecords(year: 2019, month: 2))
        print()
//        print(PlantRecord.loadRecords(year: 2018, month: 2) ?? "是NULL，我死了")
//        let record = PlantRecord(minute: 233, imgName: "图片名", year: 2018, month: 2, day: 4)
//        record?.save()
//        print(PlantRecord.loadRecords(year: 2018, month: 2) ?? "人间失格")
//
//        if cancelable {
//            quit()
//        } else {
//            let message = circleTimer.treeHasGrownUp() ?
//                LocalizationKey.GiveupAlertHoldOnMessage.translate() : LocalizationKey.GiveupAlertDeathMessage.translate()
//            let alert = UIAlertController(
//                title: LocalizationKey.GiveupAlertTitle.translate(),
//                message: message,
//                preferredStyle: .alert
//            )
//            alert.addAction(.init(
//                title: LocalizationKey.Cancel.translate(),
//                style: .cancel
//                ))
//            alert.addAction(.init(
//                title: LocalizationKey.Yes.translate(),
//                style: .destructive,
//                handler: { (_) in self.end() }
//                ))
//            present(alert, animated: true, completion: nil)
//        }
    }
    
    @IBAction func returnToMainpage(_ sender: Any) {
        quit()
    }
    
    @IBAction func showMusicSelector(_ sender: Any) {
        guard let soundSelector = storyboard?.instantiateViewController(withIdentifier: "SoundSelector") as? SoundSelectorVC else { return }
        soundSelector.modalPresentationStyle = .popover
        soundSelector.preferredContentSize = CGSize(width: 200, height: 280)
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
    
    func setSoundButtonStyle() {
        let soundOn: Bool = soundPlayer.soundKey != .None
        soundButton.setImage(UIImage(named: soundOn ? "sound-on" : "sound-off"), for: .normal)
    }
    
    private func setStopButtonTitle() {
        let title = cancelable ?
            "\(LocalizationKey.Cancel.translate()) (\(cancelableTimeLimit - self.circleTimer.focusTime))" :
            LocalizationKey.Giveup.translate()
        stopButton.setTitle(title, for: .normal)
    }
    
    private func quit() {
        if let observer = backgroundObserver { NotificationCenter.default.removeObserver(observer) }
        if let observer = returnObserver { NotificationCenter.default.removeObserver(observer) }
        self.soundPlayer.invalidate()
        dismiss(animated: true)
    }
    
    private func end() {
        print(circleTimer.treeHasGrownUp())
        circleTimer.end()
        mainTimer?.invalidate()
        backgroundTimer?.invalidate()
        soundPlayer.invalidate()
        
        returnButton.isEnabled = true
        stopButton.isHidden = true
        soundButton.isHidden = true
        
        print(circleTimer.treeHasGrownUp())
        let message = circleTimer.treeHasGrownUp() ?
            LocalizationKey.NotificationSuccess.translate() :
            LocalizationKey.NotificationDeath.translate()
        print("消息是：\(message)")
        sendNotification(message)
        NotificationCenter.default.removeObserver(self.backgroundObserver!)
    }
    
    private func backgroundCountdown() {
        sendNotification(LocalizationKey.NotificationAlert.translate())
        backgroundTime = backgroundTimeLimit
        backgroundTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: false, block: { (_) in
            self.backgroundTime = 0
            self.end()
        })
    }
    
    private func sendNotification(_ message: String) {
        let content = UNMutableNotificationContent()
        content.body = message
        content.sound = UNNotificationSound.default
        content.badge = 0
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: message, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    private func returnFromBackground() {
        if backgroundTime == 0 {
            circleTimer.end() // 因为在后台不能响应界面更新，所以在出现时重新刷新
        } else {
            backgroundTimer?.invalidate()
            backgroundTime = backgroundTimeLimit
        }
    }
}
