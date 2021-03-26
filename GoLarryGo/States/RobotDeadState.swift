//
//  RobotDeadState.swift
//  GoLarryGo
//
//  Created by Samuel Sales on 17/03/21.
//

import UIKit
import GameplayKit

class RobotDeadState: GKState {
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
        print("robot dead")
        
        animatedSpriteComponent?.setAnimationSingle(atlasName: "robotDead")
        animatedSpriteComponent?.spriteNode.removeAllActions()
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}
