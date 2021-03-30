//
//  SoundManager.swift
//  GoLarryGo
//
//  Created by Jhennyfer Rodrigues de Oliveira on 22/03/21.
//

import Foundation
import AVFoundation

private var audioPlayers : [AVAudioPlayer] = []

enum Players {
    case soundtrack
    case buttonSound
    case dyingRobot
    case jumpingLarry
    case dyingLarry
}

class AVAudioPlayerManager: NSObject {
    static var sharedPlayerManager = AVAudioPlayerManager()
    
    // Given the URL of a sound file, either create or reuse an audio player
    private func player(url : URL) -> AVAudioPlayer? {
        
        // Try and find a player that can be reused and is not playing
        let availablePlayers = audioPlayers.filter { (player) -> Bool in
            return  player.url == url
        }
        
        // If we found one, return it
        if let playerToUse = availablePlayers.first {
            return playerToUse
        }
        
        // Didn't find one? Create a new one
        do {
            let newPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayers.append(newPlayer)
                return newPlayer
        } catch let error {
            print("Couldn't load \(url.lastPathComponent): \(error)")
            return nil
        }
    }

    // play a specific sound
    private func getSoundURL(of players: Players) -> URL {
        
        guard let soundtrackFileURL = Bundle.main.url(forResource: "03 Chibi Ninja", withExtension:"mp3") else {
            print("Sound URL not found")
            return URL(fileURLWithPath: "")
        }
        
        guard let buttonSoundFileURL = Bundle.main.url(forResource: "botao", withExtension:"mp3") else {
            print("Sound URL not found")
            return URL(fileURLWithPath: "")
        }
        
        guard let dyingRobotSoundFileURL = Bundle.main.url(forResource: "roboMorrendo", withExtension:"mp3") else {
            print("Sound URL not found")
            return URL(fileURLWithPath: "")
        }
        
        guard let jumpingLarrySoundFileURL = Bundle.main.url(forResource: "larryPulando", withExtension:"mp3") else {
            print("Sound URL not found")
            return URL(fileURLWithPath: "")
        }
        
        guard let dyingLarryFileURL = Bundle.main.url(forResource: "larryMorrendo", withExtension:"mp3") else {
            print("Sound URL not found")
            return URL(fileURLWithPath: "")
        }
        
        switch players {
        case .soundtrack:
            player(url: soundtrackFileURL)?.numberOfLoops = -1
            return soundtrackFileURL
        case .buttonSound:
            return buttonSoundFileURL
        case .dyingRobot:
            return dyingRobotSoundFileURL
        case .jumpingLarry:
            return jumpingLarrySoundFileURL
        case .dyingLarry:
            return dyingLarryFileURL
        }
    }
    
    private func playSound(of players: Players) {
        player(url: getSoundURL(of: players))?.play()
    }
    
    // pause specific sound
    func pauseSound(of players: Players) {
        player(url: getSoundURL(of: players))?.pause()
    }
    
    // stop specific sound
    func stopSound(of players: Players) {
        player(url: getSoundURL(of: players))?.stop()
        player(url: getSoundURL(of: players))?.currentTime = 0
    }
    
    // stop all sounds
    func stopSounds() {
        for player in audioPlayers {
            player.stop()
        }
    }
    
    //     play sound if sound is on in User Defaults
    func playSoundIfSoundIsOn(of sound: Players) {
        if UserDefaultsConfiguration.sharedUserDefaultConfig.isSoundOn() {
            playSound(of: sound)
        }
    }
    
}

