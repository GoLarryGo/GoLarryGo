//
//  SoundManager.swift
//  GoLarryGo
//
//  Created by Jhennyfer Rodrigues de Oliveira on 22/03/21.
//

import Foundation
import AVFoundation

private var players : [AVAudioPlayer] = []


enum Players {
    case soundtrackFileURL
    case buttonSoundFileURL
    case dyingRobotSoundtrackFileURL
    case jumpingLarrySoundFileURL
    case dyingLarryFileURL
}
class AVAudioPlayerManager: NSObject {
    static var sharedPlayerManager = AVAudioPlayerManager()
    // Given the URL of a sound file, either create or reuse an audio player
    private func player(url : URL) -> AVAudioPlayer? {
        print(players.count)
        
        // Try and find a player that can be reused and is not playing
        let availablePlayers = players.filter { (player) -> Bool in
            return player.isPlaying == false && player.url == url
        }
        
        // If we found one, return it
        if let playerToUse = availablePlayers.first {
            return playerToUse
        }
        
        // Didn't find one? Create a new one
        do {
            let newPlayer = try AVAudioPlayer(contentsOf: url)
            players.append(newPlayer)
            return newPlayer
        } catch let error {
            print("Couldn't load \(url.lastPathComponent): \(error)")
            return nil
        }
        
        
    }
    
    func playSound(of players: Players) {
        
        guard let soundtrackFileURL = Bundle.main.url(forResource: "03 Chibi Ninja", withExtension:"mp3") else {
            print("Sound URL not found")
            return
        }
        
        guard let buttonSoundFileURL = Bundle.main.url(forResource: "botao", withExtension:"mp3") else {
            print("Sound URL not found")
            return
        }
        
        guard let dyingRobotSoundtrackFileURL = Bundle.main.url(forResource: "roboMorrendo", withExtension:"mp3") else {
            print("Sound URL not found")
            return
        }
        
        guard let jumpingLarrySoundFileURL = Bundle.main.url(forResource: "larryPulando", withExtension:"mp3") else {
            print("Sound URL not found")
            return
        }
        
        guard let dyingLarryFileURL = Bundle.main.url(forResource: "larryMorrendo", withExtension:"mp3") else {
            print("Sound URL not found")
            return
        }
        
        switch players {
        case .soundtrackFileURL:
            player(url: soundtrackFileURL)?.numberOfLoops = -1
            player(url: soundtrackFileURL)?.play()
        case .buttonSoundFileURL:
            player(url: buttonSoundFileURL)?.play()
        case .dyingRobotSoundtrackFileURL:
            player(url: dyingRobotSoundtrackFileURL)?.play()
        case .jumpingLarrySoundFileURL:
            player(url: jumpingLarrySoundFileURL)?.play()
        case .dyingLarryFileURL:
            player(url: dyingLarryFileURL)?.play()
        }
        
    }
    
    func stopSounds() {
        for player in players {
            player.stop()
        }
    }
    
    func playSoundIfSoundIsOn() {
        if UserDefaultsConfiguration.sharedUserDefaultConfig.isSoundOn() {
            AVAudioPlayerManager.sharedPlayerManager.playSound(of: .soundtrackFileURL)
        }
    }
    
}
