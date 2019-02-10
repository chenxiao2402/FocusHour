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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func StopButtonTapped(_ sender: Any) {
        let alert = UIAlertController(
            title: "Give up?", message: "Your Tree will die",
            preferredStyle: .alert
        )
        alert.addAction(.init(
            title: "cancel", style: .cancel
        ))
        alert.addAction(.init(
            title: "Yes", style: .destructive, handler: { (_) in
                self.timer.invalidate()
                self.returnButton.isEnabled = true
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func returnToMainpage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
