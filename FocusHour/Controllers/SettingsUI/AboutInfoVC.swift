//
//  AboutInfo.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/12.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class AboutInfoVC: UIViewController {

    @IBOutlet weak var textArea: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UITool.setBackgroundImage(view, random: false)
        navigationItem.title = SettingKey.About.translate()
        let description = LocalizationKey.Description.translate()
        let aboutMe = LocalizationKey.AboutMe.translate()
        textArea.text = "\(description)\n\n\(aboutMe)"
    }
    

}
