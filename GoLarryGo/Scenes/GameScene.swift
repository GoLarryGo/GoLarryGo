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
    
    // Iniciar o tempo para update time
    var lastUpdateTimeInterval: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        
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
            visualComponentFloor.node.size = CGSize(width: size.width, height: size.height)
            visualComponentFloor.node.zPosition = -1
        }
        
        //cria a instância character
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
//        let deltaTime = currentTime - lastUpdateTimeInterval
//        lastUpdateTimeInterval = currentTime
    }
}
