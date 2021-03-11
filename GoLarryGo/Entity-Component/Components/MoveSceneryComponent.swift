//
//  MoveSceneryComponent.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 09/03/21.
//
//
import GameplayKit
import SpriteKit

class MoveSceneryComponent: GKComponent {
    
    var spriteNode: SKSpriteNode? {
        self.entity?.component(ofType: AnimatedSceneryComponent.self)?.spriteNode
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        spriteNode?.position.x -= 1

    }
}


