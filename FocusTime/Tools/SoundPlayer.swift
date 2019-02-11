//
//  SoundPlayer.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/11.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import AVFoundation

class SoundPlayer {
    private var audioPlayer: AVAudioPlayer!
    var soundKey: SoundEnum = .None
    
    func play(sound: SoundEnum) {
        soundKey = sound
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: SoundEnum.getURL(sound: sound))
            audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            audioPlayer.play()
        } catch {
            audioPlayer = nil
        }
    }
    
    func stop() {
        soundKey = .None
        audioPlayer?.stop()
    }
    
    func invalidate() {
        soundKey = .None
        audioPlayer = nil
    }
}
