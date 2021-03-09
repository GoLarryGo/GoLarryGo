//
//  GameScene.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 08/03/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Criamos a referência o gerenciador de entidades
    var entityManager: EntityManager!
    var character: CharacterEntity!
    /*private lazy var background: SKSpriteNode = {
        let background = SKSpriteNode(imageNamed: "back03")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = CGSize(width: size.width, height: size.height)
        background.zPosition = 0
        return background
    }()*/
    // Iniciar o tempo para update time
    var lastUpdateTimeInterval: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        //addChild(background)
        
        // cria uma instância do gerenciador de entidades
        entityManager = EntityManager(scene: self)
        
        //cria a instância background
        let background = BackgroundEntity()
        entityManager.add(background)
        if let visualComponentFloor = background.component(ofType: VisualComponent.self) {
            visualComponentFloor.node.position = CGPoint(x: size.width/2, y: size.height/2)
            visualComponentFloor.node.size = CGSize(width: size.width, height: size.height)
            visualComponentFloor.node.zPosition = -6
        }
        
        //cria a instância sol
        let sun = SunEntity()
        entityManager.add(sun)
        if let visualComponentFloor = sun.component(ofType: VisualComponent.self) {
            visualComponentFloor.node.position = CGPoint(x: size.width/2, y: size.height/1.3)
            visualComponentFloor.node.size = CGSize(width: size.width * 0.2, height: size.height * 0.2)
            visualComponentFloor.node.zPosition = -4
        }
        
        //cria a instância sol
        let clouds = CloudsEntity()
        entityManager.add(clouds)
        if let visualComponentFloor = clouds.component(ofType: VisualComponent.self) {
            visualComponentFloor.node.position = CGPoint(x: size.width/2, y: size.height/1.3)
            visualComponentFloor.node.size = CGSize(width: size.width * 0.9, height: size.height * 0.3)
            visualComponentFloor.node.zPosition = -3
        }
        
        //cria a instância montanha alternada
        let montainAlt = MontainAltEntity()
        entityManager.add(montainAlt)
        if let visualComponentFloor = montainAlt.component(ofType: VisualComponent.self) {
            visualComponentFloor.node.position = CGPoint(x: size.width/2, y: size.height/2.3)
            visualComponentFloor.node.size = CGSize(width: size.width, height: size.height * 0.2)
            visualComponentFloor.node.zPosition = -3
        }
        
        //cria a instância montanha fixa no cenário
        let montainFix = MontainFixEntity()
        entityManager.add(montainFix)
        if let visualComponentMontainFix = montainFix.component(ofType: VisualComponent.self) {
                visualComponentMontainFix.node.size = CGSize(width: size.width, height: size.height * 0.2)
                visualComponentMontainFix.node.position = CGPoint(x: size.width/2, y: size.height/2.5)
                visualComponentMontainFix.node.zPosition = -2
//            if let moveComponentMontain = montainFix.component(ofType: MoveSceneryComponent.self) {
//                visualComponentMontainFix.node.run(moveComponentMontain.setAnimation(sizeX: size.width))
//            }
            }
    
        //cria a instância chão
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
//        let deltaTime = currentTime - lastUpdateTimeInterval
//        lastUpdateTimeInterval = currentTime
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let visualComponentCharacter = character.component(ofType: VisualComponent.self) {
            if visualComponentCharacter.node.position.y < 60 {
                visualComponentCharacter.node.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 6))
            }
        }
    }
}
