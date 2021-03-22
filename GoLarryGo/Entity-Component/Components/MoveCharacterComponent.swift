//
//  MoveCharacterComponent.swift
//  GoLarryGo
//
//  Created by aluno on 12/03/21.
//
import SpriteKit
import GameplayKit
import UIKit

class MoveCharacterComponent: GKComponent {
    
    var walk: Bool = true
    var velocity: CGFloat
    
    var spriteNode: SKSpriteNode? {
        self.entity?.component(ofType: AnimatedSpriteComponent.self)?.spriteNode
    }
    
    init(velocity: CGFloat = 3) {
        self.velocity = velocity
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func halt() {
        self.walk = false
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        if walk {
            spriteNode?.position.x += velocity
        } else {
            spriteNode?.position.x += 0
        }
    }
}
