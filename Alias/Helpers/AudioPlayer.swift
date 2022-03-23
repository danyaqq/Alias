//
//  AudioPlayer.swift
//  Alias
//
//  Created by Даня on 25.02.2022.
//

import Foundation
import AVFoundation

class AudioPlayer{
    var player: AVAudioPlayer?
    
    func playSound(_ title: String){
        guard let url = Bundle.main.url(forResource: title, withExtension: "mp3") else { return }
        do{
        player = try AVAudioPlayer(contentsOf: url)
        } catch let error{
            print(error.localizedDescription)
        }
        player?.play()
    }
}
