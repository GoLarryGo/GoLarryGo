//
//  CharacterDeadState.swift
//  GoLarryGo
//
//  Created by Samuel Sales on 15/03/21.
//
import SpriteKit
import GameplayKit
import UIKit

class CharacterDeadState: GKState {
    var entity: GKEntity
    
    var animatedSpriteComponent: AnimatedSpriteComponent? {
        self.entity.component(ofType: AnimatedSpriteComponent.self)
    }
    
    var moveComponent: MoveCharacterComponent? {
        self.entity.component(ofType: MoveCharacterComponent.self)
    }
    
    init(_ entity: GKEntity){
        self.entity = entity
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("larry dead")
        AVAudioPlayerManager.sharedPlayerManager.stopSound(of: .soundtrack)
        AVAudioPlayerManager.sharedPlayerManager.playSoundIfSoundIsOn(of: .dyingLarry)
        animatedSpriteComponent?.setAnimationSingle(atlasName: "larryDead")
        moveComponent?.halt()
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}
