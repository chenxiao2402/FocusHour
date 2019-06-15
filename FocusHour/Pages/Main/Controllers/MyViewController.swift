//
//  MyViewController.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var redView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: self, action: #selector(MyViewController.fadeAway))
        backgroundView.addGestureRecognizer(gesture)
        backgroundView.isUserInteractionEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        redView.center.y -= view.bounds.height * 0.5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.redView.center.y += self.view.bounds.height * 0.5
        }, completion: nil)
    }
    
    @objc func fadeAway() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.redView.center.y += self.view.bounds.height * 0.5
        }, completion: {(_) in
            self.view.removeFromSuperview()
        })
    }
}
