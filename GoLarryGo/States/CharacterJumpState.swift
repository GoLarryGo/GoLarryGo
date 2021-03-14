//
//  CharacterJumpState.swift
//  GoLarryGo
//
//  Created by aluno on 12/03/21.
//
import SpriteKit
import GameplayKit
import UIKit

class CharacterJumpState: GKState {
    var entity: GKEntity
    
    var animatedSpriteComponent: AnimatedSpriteComponent? {
        self.entity.component(ofType: AnimatedSpriteComponent.self)
    }

    var jumpComponent: JumpCharacterComponent? {
        self.entity.component(ofType: JumpCharacterComponent.self)
    }

    init(_ entity: GKEntity){
        self.entity = entity
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("larry jump")
        if animatedSpriteComponent?.spriteNode.position.y == 30 {
            animatedSpriteComponent?.setAnimation(atlasName: "larryJump")
            jumpComponent?.jump()
            
        }
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}
