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
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(view.frame.size)
        getRandomBackgroundImage()?.draw(in: self.view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor.init(patternImage: image!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func startButtonTapped(_ sender: Any) {
        print(timeSetter.focusMinutes)
    }
}

extension SetTimeViewController {
    func getRandomBackgroundImage() -> UIImage? {
        let imageNum = 8 // 参见Assets.xcassets中的BackgroundImage文件夹
        let index = Int(arc4random()) % imageNum
        return UIImage(named: "background-\(index)")
    }
}
