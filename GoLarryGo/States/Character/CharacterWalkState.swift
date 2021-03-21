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

    var moveComponent: MoveCharacterComponent? {
        self.entity.component(ofType: MoveCharacterComponent.self)
    }

    init(_ entity: GKEntity){
        self.entity = entity
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("larry")

        animatedSpriteComponent?.setAnimation(atlasName: "larryWalk")
        //moveComponent?.
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        //quando ele tiver saindo
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
}
