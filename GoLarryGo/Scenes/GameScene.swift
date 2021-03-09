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
    
    /*private lazy var background: SKSpriteNode = {
        let background = SKSpriteNode(imageNamed: "back03")
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.size = CGSize(width: size.width, height: size.height)
        background.zPosition = 0
        return background
    }()*/
    
    override func didMove(to view: SKView) {
        
        //addChild(background)
        
        // cria uma instância do gerenciador de entidades
        entityManager = EntityManager(scene: self)
        
        let floor = FloorEntity()
        entityManager.add(floor)
        if let visualComponentFloor = floor.component(ofType: VisualComponent.self) {
            visualComponentFloor.node.position = CGPoint(x: size.width/2, y: size.height/2)
            visualComponentFloor.node.size = CGSize(width: size.width, height: size.height)
            visualComponentFloor.node.zPosition = -1
        }
        
        
        
        let character = CharacterEntity()
        entityManager.add(character)
        if let visualComponentCharacter = character.component(ofType: VisualComponent.self) {
            visualComponentCharacter.node.position = CGPoint(x: 50, y: 20)
            if let runComponent = character.component(ofType: RunComponent.self) {
                visualComponentCharacter.node.run(runComponent.startRun())
            }
        }
        
        


    }

    
    override func update(_ currentTime: TimeInterval) {

    }
}
