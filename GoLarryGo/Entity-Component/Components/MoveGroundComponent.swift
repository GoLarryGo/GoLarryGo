//
//  MoveGroundComponent.swift
//  GoLarryGo
//
//  Created by Samuel Sales on 09/04/21.
//

import UIKit
import GameplayKit

class MoveGroundComponent: GKComponent {
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
    
    func stopMove() {
        spriteNode?.removeAllActions()
    }
    
    func startMove() {
        let move = SKAction.moveBy(x: -velocity, y: 0, duration: 0.1)
        spriteNode?.run(SKAction.repeatForever(move))
    }
}
