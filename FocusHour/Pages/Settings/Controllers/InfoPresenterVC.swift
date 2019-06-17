//
//  AboutInfo.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/12.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class InfoPresenterVC: UIViewController {

    @IBOutlet weak var textArea: UITextView!
    var navTitle: String!
    var info: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navTitle
        textArea.text = info
        UITool.setBackgroundImage(view, imageName: Theme.getCurrentTheme().backgroundImage)
        self.navigationController?.navigationBar.barTintColor = Theme.getCurrentTheme().themeColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textArea.setContentOffset(.zero, animated: false)
    }

}
