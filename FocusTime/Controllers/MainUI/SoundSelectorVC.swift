//
//  PopoverViewController.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/11.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class SoundSelectorVC: UITableViewController {
    
    var soundList: [SoundEnum] = []
    var timerVC: TimerVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorEnum.getColor(name: .LightYellow)
        soundList = SoundEnum.getKeyList()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundSelectorCell", for: indexPath) as! SoundSelectorCell
        cell.keyVlue = soundList[indexPath.row].rawValue
        if timerVC.soundPlayer.soundKey == soundList[indexPath.row] {
            cell.setSelected(true, animated: true)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        timerVC.soundPlayer.play(sound: soundList[indexPath.row])
        self.dismiss(animated: true, completion: nil)
        timerVC.setSoundButtonStyle()
    }
}
