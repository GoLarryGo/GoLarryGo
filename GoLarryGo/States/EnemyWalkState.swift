//
//  WalkState.swift
//  GoLarryGo
//
//  Created by aluno on 11/03/21.
//

import Foundation
import SpriteKit
import GameplayKit

enum EnemyDirection: String {
    case left = "roboWalkLeft"
    case right = "roboWalkRight"
    case none
}

class EnemyWalkLeftState: EnemyWalkState {
    override var direction: EnemyDirection {
        .left
    }
}

class EnemyWalkRightState: EnemyWalkState {
    override var direction: EnemyDirection {
        .right
    }
}

class EnemyWalkState: GKState {
    var entity: GKEntity
    
    var direction: EnemyDirection {
        .none
    }
    
    var animatedSpriteComponent: AnimatedSpriteComponent? {
        self.entity.component(ofType: AnimatedSpriteComponent.self)
    }

    init(_ entity: GKEntity){
        self.entity = entity
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("walkState")

        animatedSpriteComponent?.setAnimation(atlasName: "robotWalkLeft")
        //walkComponent?.walk(direction: direction)
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}
