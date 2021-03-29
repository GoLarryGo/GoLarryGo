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
        let animetedSpriteComponent = AnimatedSpriteComponent(atlasName: "robotWalkLeft")
        animetedSpriteComponent.spriteNode.size = CGSize(width: 64, height: 64)
        addComponent(
            PlayerControlComponent(states: [
                RobotWalkState(self),
                RobotDeadState(self)
        ]))
        
        addComponent(animetedSpriteComponent)
        setupPhysicsBody(component: animetedSpriteComponent)
    }
    
    func setupPhysicsBody(component: AnimatedSpriteComponent) {
        //component.spriteNode.physicsBody = SKPhysicsBody(circleOfRadius: component.spriteNode.size.height/2)
        let sizeComponent = CGSize(width: component.spriteNode.size.width/2, height: component.spriteNode.size.height + 6)
        
        component.spriteNode.physicsBody = SKPhysicsBody(texture: component.spriteNode.texture!, size: sizeComponent)
        component.spriteNode.physicsBody?.isDynamic = true
        component.spriteNode.physicsBody?.allowsRotation = false
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let prototype = type(of: self).init()
        print("Values defined in BaseClass have been cloned!")
        return prototype
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
