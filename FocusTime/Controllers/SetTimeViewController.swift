//
//  SetTimeViewController.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/4.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SetTimeViewController: ViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var timeSetter: CircleSlider!
    @IBOutlet weak var startButton: StartButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITool.setToolButtonSize(settingsButton, ratio: 1.0)
        setBackgroundImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startButton.setButtonStyle()
    }
    
    private func setBackgroundImage() {
        UIGraphicsBeginImageContext(view.frame.size)
        getRandomBackgroundImage()?.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor.init(patternImage: image!)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let timeConterController = segue.destination as? TimeCounterController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        let totalFocusTime = timeSetter.remainingMinutes * 60
        let background = view.backgroundColor
        timeConterController.view.backgroundColor = background
        timeConterController.circleTimer.remainingTime = totalFocusTime
    }
}

extension SetTimeViewController {
    private func getRandomBackgroundImage() -> UIImage? {
        let imageNum = 8 // 参见Assets.xcassets中的BackgroundImage文件夹
        let index = Int(arc4random()) % imageNum
        return UIImage(named: "background-\(index)")
    }
}
