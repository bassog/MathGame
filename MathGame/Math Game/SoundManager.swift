//
//  SoundManager.swift
//  Math Game
//
//  Created by Gregory Basso on 30/05/2020.
//  Copyright © 2020 Andrew basso. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect {
        case endGame
        case timeUp
        case incorrect
    }
    
    func playSound(effect:SoundEffect) {
        
        var soundFilename = ""
        
        switch effect {
            
            case .endGame:
                soundFilename = "andrew"
            
            case .timeUp:
                       soundFilename = "dingcorrect"
            
            case .incorrect:
                       soundFilename = "wrong"
            
        }
        
        //Get the path to the resource
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: ".wav")
        
        //Check that it is not nil
        guard bundlePath != nil else {
            //Couldn't find rsource, exit
            return
        }
                
        let url = URL(fileURLWithPath: bundlePath!)
     
        do {
            //Create the audio player
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            //PLay the sound effect
            audioPlayer?.play()
        }
        
        catch {
            print("Couldn't create an audio player")
            return
        }
        
    }
}
