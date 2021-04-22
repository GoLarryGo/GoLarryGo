//
//  MoveRobotComponent.swift
//  GoLarryGo
//
//  Created by Samuel Sales on 26/03/21.
//

import SpriteKit
import GameplayKit
import UIKit

enum RobotDirection: String {
    case left = "roboWalkLeft"
    case right = "roboWalkRight"
    case none
}

class MoveRobotComponent: GKComponent {
    
    var walk: RobotDirection = .none
    var velocity: CGFloat
    
    var spriteNode: SKSpriteNode? {
        self.entity?.component(ofType: AnimatedSpriteComponent.self)?.spriteNode
    }
    
    init(velocity: CGFloat = 8) {
        self.velocity = velocity
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMove(direction: RobotDirection, robotType: String = "robotWalkLeft") {
        if direction == .none && walk == .none && robotType != "robotWalkLeft" {
            return
        }
        spriteNode?.removeAllActions()
        
        guard let spriteComponent = self.entity?.component(ofType:  AnimatedSpriteComponent.self) else {return}
        spriteComponent.setAnimation(atlasName: robotType)
        
        if direction == .left {
            let move = SKAction.moveBy(x: -velocity, y: 0, duration: 0.1)
            spriteNode?.run(SKAction.repeatForever(move))
        } else if walk == .right {
            let move = SKAction.moveBy(x: velocity, y: 0, duration: 0.1)
            spriteNode?.xScale = -1
            spriteNode?.run(SKAction.repeatForever(move))
        } else if robotType == "robotWalkLeft" {
            let move = SKAction.moveBy(x: -velocity, y: 0, duration: 0.1)
            spriteNode?.run(SKAction.repeatForever(move))
        } 
        walk = direction
    }
    
    func changeVelocity(velocity: CGFloat) {
        self.velocity = velocity
    }
    
}
