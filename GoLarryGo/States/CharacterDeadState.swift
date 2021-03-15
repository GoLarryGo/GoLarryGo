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

    init(_ entity: GKEntity){
        self.entity = entity
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("larry dead")
        animatedSpriteComponent?.setAnimation(atlasName: "larryJump")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}
