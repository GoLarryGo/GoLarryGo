//
//  MoveRobotComponent.swift
//  GoLarryGo
//
//  Created by Samuel Sales on 26/03/21.
//

import SpriteKit
import GameplayKit
import UIKit

class MoveRobotComponent: GKComponent {
    
    var walk: RobotDirection = .none
    var velocity: CGFloat
    
    var spriteNode: SKSpriteNode? {
        self.entity?.component(ofType: AnimatedSpriteComponent.self)?.spriteNode
    }
    
    init(velocity: CGFloat = 2) {
        self.velocity = velocity
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func halt() {
        self.walk = .none
    }
    
    func startMove(direction: RobotDirection) {
        self.walk = direction
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        if walk == .left {
            spriteNode?.position.x -= velocity
        } else if walk == .right {
            spriteNode?.xScale *= -1
            spriteNode?.position.x -= velocity
        }
    }
}
