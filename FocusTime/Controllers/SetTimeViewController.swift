//
//  SetTimeViewController.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/4.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SetTimeViewController: ViewController {

    //@IBOutlet weak var progressBar: CircularProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap() {
//        progressBar.labelSize = 60
//        progressBar.safePercent = 100
//        progressBar.setProgress(to: 0.5, withAnimation: true)
    }
}
