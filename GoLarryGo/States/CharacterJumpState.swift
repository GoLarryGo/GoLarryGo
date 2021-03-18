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
        animatedSpriteComponent?.setAnimationSingle(atlasName: "larryJump")
        jumpComponent?.jump(completion: {
            self.stateMachine?.enter(CharacterWalkState.self)
        })
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        //quando ele tiver saindo
    }
    
    /*override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        super.isValidNextState(stateClass)
        return stateClass == CharacterWalkState.self
    }*/

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}
