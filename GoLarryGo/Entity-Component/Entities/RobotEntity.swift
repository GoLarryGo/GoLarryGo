//
//  RobotEntity.swift
//  GoLarryGo
//
//  Created by Samuel Sales on 15/03/21.
//
import SpriteKit
import GameplayKit

class RobotEntity: GKEntity {
    
    override init() {
        super.init()
        // Utiliza o componente AnimatedSpriteComponent para gerar o sprite da entidade
        let animetedSpriteComponent = AnimatedSpriteComponent(atlasName: "roboWalkLeft")
        addComponent(animetedSpriteComponent)
        setupPhysicsBody(component: animetedSpriteComponent)
    }
    
    func setupPhysicsBody(component: AnimatedSpriteComponent) {
        component.spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: 32)
        component.spriteNode.physicsBody?.isDynamic = true
        component.spriteNode.physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
