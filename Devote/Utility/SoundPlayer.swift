//
//  SoundPlayer.swift
//  Devote
//
//  Created by Philip Al-Twal on 10/24/22.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        guard let urlPath = URL(string: path) else {
            print("Error [  ] Failed to create URL from path: \(path)")
            return
        }
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: urlPath)
            audioPlayer?.play()
        }catch{
            print("Error [  ] Failed to play sound file with path: \(path)")
        }
    }
}
