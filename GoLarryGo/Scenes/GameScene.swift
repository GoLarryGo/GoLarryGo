//
//  GameScene.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 08/03/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // criamos a referência o gerenciador de entidades
    var entityManager: EntityManager!
    var character: CharacterEntity!
    /*private lazy var background: SKSpriteNode = {
        let background = SKSpriteNode(imageNamed: "back03")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = CGSize(width: size.width, height: size.height)
        background.zPosition = 0
        return background
    }()*/
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        //addChild(background)
        
        // cria uma instância do gerenciador de entidades
        entityManager = EntityManager(scene: self)
        
        let floor = FloorEntity()
        entityManager.add(floor)
        if let visualComponentFloor = floor.component(ofType: VisualComponent.self) {
            visualComponentFloor.node.position = CGPoint(x: size.width/2, y: size.height/2)
            visualComponentFloor.node.size = CGSize(width: size.width, height: 300)
            visualComponentFloor.node.zPosition = -1
        }
        
        let topFloor = SKSpriteNode()
        topFloor.position = CGPoint(x: 0, y: 30)
        topFloor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.size.width, height: 30))
        topFloor.physicsBody?.isDynamic = false
        addChild(topFloor)
        
        
        
        character = CharacterEntity()
        
        if let visualComponentCharacter = character.component(ofType: VisualComponent.self) {
            visualComponentCharacter.node.position = CGPoint(x: 50, y: 400)
            if let runComponent = character.component(ofType: RunComponent.self) {
                visualComponentCharacter.node.run(runComponent.startRun())
            }
        }
        entityManager.add(character)
        


    }

    
    override func update(_ currentTime: TimeInterval) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let visualComponentCharacter = character.component(ofType: VisualComponent.self) {
            if visualComponentCharacter.node.position.y < 60 {
                visualComponentCharacter.node.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 6))
            }
        }
    }
}
