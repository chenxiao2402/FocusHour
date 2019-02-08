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
    @IBOutlet weak var timeSetter: CircleTimeSetter!
    @IBOutlet weak var startButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
    }
    
    private func setBackgroundImage() {
        UIGraphicsBeginImageContext(view.frame.size)
        getRandomBackgroundImage()?.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor.init(patternImage: image!)
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        print(timeSetter.focusMinutes)
    }
}

extension SetTimeViewController {
    private func getRandomBackgroundImage() -> UIImage? {
        let imageNum = 7 // 参见Assets.xcassets中的BackgroundImage文件夹
        let index = Int(arc4random()) % imageNum
        return UIImage(named: "background-\(index)")
    }
}
