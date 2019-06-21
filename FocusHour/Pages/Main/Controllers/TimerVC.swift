//
//  TimeCounterController.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/9.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import UserNotifications


enum FocusState {
    case Cancelable
    case OnGoing
    case Finished
}


class TimerVC: UIViewController {
    
    let soundPlayer: SoundPlayer = SoundPlayer()
    let backgroundTimeLimit: Int = 10
    let cancelableTimeLimit: Int = 10
    private var mainTimer: Timer!
    private var focusState = FocusState.Cancelable {
        didSet {
            let finished = focusState == .Finished
            returnButton.isHidden = !finished
            tagButton.isHidden = finished
            soundButton.isHidden = finished
            stopButton.isHidden = finished
        }
    }
    private var backgroundObserver: NSObjectProtocol?
    private var returnObserver: NSObjectProtocol?
    private var backgroundTimer: Timer!
    private var backgroundTime: Int!
    
    @IBOutlet weak var circleTimer: CircleTimer!
    @IBOutlet weak var stopButton: StopButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var workingModeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundTime = backgroundTimeLimit
        UITool.setToolButtonSize(returnButton, ratio: 432.0 / 512.0)
        UITool.setToolButtonSize(soundButton, ratio: 1.0)
        setSoundButtonStyle()
        setStopButtonTitle()
        workingModeLabel.isHidden = !PreferenceTool.isMode(ofName: .WorkingMode)
        workingModeLabel.text = LocalizationKey.WorkingMode.translate()
        focusState = .Cancelable
        
        mainTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
            if self.circleTimer.remainingTime > 0 {
                self.circleTimer.resetTime()
                self.focusState = self.circleTimer.focusSeconds <= self.cancelableTimeLimit ? .Cancelable : .OnGoing
                self.setStopButtonTitle()
            } else {
                self.end()
            }
        })
        
        if (!PreferenceTool.isMode(ofName: .WorkingMode)) {
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
    }
    
    @IBAction func StopButtonTapped(_ sender: Any) {
        if focusState == .Cancelable {
            // 随机生成数据并保存，注意正式使用的时候删掉
            PlantRecord.generateRandomRecords()
            quit()
        } else if focusState == .OnGoing {
            let message = circleTimer.treeHasGrownUp() ?
                LocalizationKey.GiveupAlertHoldOnMessage.translate() : LocalizationKey.GiveupAlertDeathMessage.translate()
            let alert = UIAlertController(
                title: LocalizationKey.GiveupAlertTitle.translate(),
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(.init(
                title: LocalizationKey.Cancel.translate(),
                style: .cancel
                ))
            alert.addAction(.init(
                title: LocalizationKey.Yes.translate(),
                style: .destructive,
                handler: { (_) in self.end() }
                ))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func returnToMainpage(_ sender: Any) {
        quit()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case SegueKey.ShowMusicSelector.rawValue:
            let soundSelector = segue.destination as! SoundSelectorVC
            let popoverController = soundSelector.popoverPresentationController
            soundSelector.timerVC = self
            soundSelector.preferredContentSize = CGSize(width: 200, height: 280)
            popoverController?.delegate = self
            popoverController?.sourceRect = soundButton.bounds
        case SegueKey.ShowTagList.rawValue:
            let navigation = segue.destination as! UINavigationController
            let popoverController = navigation.popoverPresentationController
            navigation.preferredContentSize = CGSize(width: 200, height: 280)
            popoverController?.delegate = self
            popoverController?.sourceRect = tagButton.bounds
        default:
            return
        }
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
        let title = focusState == .Cancelable ?
            "\(LocalizationKey.Cancel.translate()) (\(cancelableTimeLimit - self.circleTimer.focusSeconds))" :
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
        if let observer = backgroundObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        
        circleTimer.drawResult()
        save()
        mainTimer?.invalidate()
        backgroundTimer?.invalidate()
        soundPlayer.invalidate()
        focusState = .Finished
        
        let message = circleTimer.treeHasGrownUp() ?
            LocalizationKey.NotificationSuccess.translate() :
            LocalizationKey.NotificationFailure.translate()
        sendNotification(message)
        
        // add coins here，放大了一千倍，正式使用的时候删掉
        PreferenceTool.addCoins(addNumber: circleTimer.focusMinutes * 1000)
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
            circleTimer.drawResult() // 因为在后台不能响应界面更新，所以在出现时重新刷新
        } else {
            backgroundTimer?.invalidate()
            backgroundTime = backgroundTimeLimit
        }
    }
    
    private func save() {
        let focusMinutes = circleTimer.focusMinutes
        let imgName = circleTimer.getRecordImageNameBy(focusMinutes: focusMinutes)
        let plantRecord = PlantRecord(imgName: imgName, minute: focusMinutes, tag: "dasfdsa")
        plantRecord?.save()
    }
}
