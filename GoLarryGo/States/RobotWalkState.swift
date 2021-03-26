//
//  WalkState.swift
//  GoLarryGo
//
//  Created by aluno on 11/03/21.
//

import Foundation
import SpriteKit
import GameplayKit

enum RobotDirection: String {
    case left = "roboWalkLeft"
    case right = "roboWalkRight"
    case none
}

class RobotWalkLeftState: RobotWalkState {
    override var direction: RobotDirection {
        .left
    }
}

class RobotWalkRightState: RobotWalkState {
    override var direction: RobotDirection {
        .right
    }
}

class RobotWalkState: GKState {
    var entity: GKEntity
    
    var direction: RobotDirection {
        .none
    }
    
    var animatedSpriteComponent: AnimatedSpriteComponent? {
        self.entity.component(ofType: AnimatedSpriteComponent.self)
    }
    
    var walkComponent: MoveRobotComponent? {
        self.entity.component(ofType: MoveRobotComponent.self)
    }

    init(_ entity: GKEntity){
        self.entity = entity
        super.init()
    }

    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        print("walkState")

        animatedSpriteComponent?.setAnimation(atlasName: "robotWalkLeft")
        walkComponent?.startMove(direction: direction)
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}
