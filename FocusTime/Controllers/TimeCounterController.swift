//
//  TimeCounterController.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/9.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class TimeCounterController: ViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var circleTimer: CircleTimer!
    @IBOutlet weak var stopButton: StopButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func StopButtonTaspped(_ sender: Any) {
        let alert = UIAlertController(
            title: "Give up?", message: "Your Tree will die",
            preferredStyle: .alert
        )
        alert.addAction(.init(
            title: "cancel", style: .cancel
        ))
        alert.addAction(.init(
            title: "Yes", style: .destructive, handler: { (_) in
                self.circleTimer.timer.invalidate()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func returnToMainpage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
