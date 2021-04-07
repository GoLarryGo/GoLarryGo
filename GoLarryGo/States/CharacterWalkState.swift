//
//  CharacterWalkState.swift
//  GoLarryGo
//
//  Created by aluno on 12/03/21.
//
import SpriteKit
import GameplayKit
import UIKit

class CharacterWalkState: GKState {
    
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

        animatedSpriteComponent?.setAnimation(atlasName: "larryWalk")
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
}
