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
        if let visualComponentBackground = background.component(ofType: VisualComponent.self) {
            visualComponentBackground.node.position = CGPoint(x: size.width/2, y: size.height/2)
            visualComponentBackground.node.size = CGSize(width: size.width, height: size.height)
            visualComponentBackground.node.zPosition = -6
        }
        
        //cria a instância sol
        let sun = SunEntity()
        entityManager.add(sun)
        if let visualComponentSun = sun.component(ofType: VisualComponent.self) {
            visualComponentSun.node.position = CGPoint(x: size.width/2, y: size.height/1.3)
            visualComponentSun.node.size = CGSize(width: size.width * 0.2, height: size.height * 0.2)
            visualComponentSun.node.zPosition = -4
            if let moveComponentSun = sun.component(ofType: MoveSunComponent.self) {
                    visualComponentSun.node.run(moveComponentSun.setAnimation(CGPoint(x: size.width/2, y: size.height/1.3)))
//                if visualComponentSun.node.position.x < 0 {
//                    entityManager.remove(sun)
//                }
            }
        }
        
        //cria a instância nuvem
        let clouds = CloudsEntity()
        entityManager.add(clouds)
        if let visualComponentClouds = clouds.component(ofType: VisualComponent.self) {
            visualComponentClouds.node.position = CGPoint(x: frame.minX, y: size.height/1.3)
            visualComponentClouds.node.size = CGSize(width: size.width, height: size.height * 0.3)
            visualComponentClouds.node.zPosition = -3
            if let moveComponentClouds = clouds.component(ofType: MoveSceneryComponent.self) {
                    visualComponentClouds.node.run(moveComponentClouds.setAnimation(sizeX: size.width))
            }
        }
        
        //cria a instância nuvem para movimento
        let clouds1 = CloudsEntity()
        entityManager.add(clouds1)
        if let visualComponentClouds1 = clouds1.component(ofType: VisualComponent.self) {
            visualComponentClouds1.node.position = CGPoint(x: frame.maxX, y: size.height/1.3)
            visualComponentClouds1.node.size = CGSize(width: size.width, height: size.height * 0.3)
            visualComponentClouds1.node.zPosition = -3
            if let moveComponentClouds1 = clouds1.component(ofType: MoveSceneryComponent.self) {
                    visualComponentClouds1.node.run(moveComponentClouds1.setAnimation(sizeX: size.width))
            }
        }
        
        //cria a instância montanha alternada
        let montainAlt = MontainAltEntity()
        entityManager.add(montainAlt)
        if let visualComponentMontainAlt = montainAlt.component(ofType: VisualComponent.self) {
            visualComponentMontainAlt.node.position = CGPoint(x: size.width/2, y: size.height/3)
            visualComponentMontainAlt.node.size = CGSize(width: size.width, height: size.height * 0.2)
            visualComponentMontainAlt.node.zPosition = -3
        }
        
        //cria a instância montanha fixa no cenário
        let montainFix = MontainFixEntity()
        entityManager.add(montainFix)
        if let visualComponentMontainFix = montainFix.component(ofType: VisualComponent.self) {
                visualComponentMontainFix.node.size = CGSize(width: size.width, height: size.height * 0.2)
            visualComponentMontainFix.node.position = CGPoint(x: frame.minX, y: size.height/3.5)
                visualComponentMontainFix.node.zPosition = -2
            if let moveComponentMontainFix = clouds1.component(ofType: MoveSceneryComponent.self) {
                    visualComponentMontainFix.node.run(moveComponentMontainFix.setAnimation(sizeX: size.width))
                }
            }
        
        //cria a instância montanha fixa no cenário
        let montainFix1 = MontainFixEntity()
        entityManager.add(montainFix1)
        if let visualComponentMontainFix1 = montainFix1.component(ofType: VisualComponent.self) {
                visualComponentMontainFix1.node.size = CGSize(width: size.width, height: size.height * 0.2)
            visualComponentMontainFix1.node.position = CGPoint(x: frame.maxX, y: size.height/3.5)
                visualComponentMontainFix1.node.zPosition = -2
            if let moveComponentMontainFix1 = clouds1.component(ofType: MoveSceneryComponent.self) {
                    visualComponentMontainFix1.node.run(moveComponentMontainFix1.setAnimation(sizeX: size.width))
                }
            }
    
        //cria a instância chão
        let floor = FloorEntity()
        entityManager.add(floor)
        if let visualComponentFloor = floor.component(ofType: VisualComponent.self) {
            visualComponentFloor.node.position = CGPoint(x: frame.minX, y: size.height/2)
            visualComponentFloor.node.size = CGSize(width: size.width, height: size.height)
            visualComponentFloor.node.zPosition = -1
            if let moveComponentFloor = floor.component(ofType: MoveSceneryComponent.self) {
                    visualComponentFloor.node.run(moveComponentFloor.setAnimation(sizeX: size.width))
                }
        }
        
        //cria a instância chão
        let floor1 = FloorEntity()
        entityManager.add(floor1)
        if let visualComponentFloor1 = floor1.component(ofType: VisualComponent.self) {
            visualComponentFloor1.node.position = CGPoint(x: frame.maxX, y: size.height/2)
            visualComponentFloor1.node.size = CGSize(width: size.width, height: size.height)
            visualComponentFloor1.node.zPosition = -1
            if let moveComponentFloor1 = clouds1.component(ofType: MoveSceneryComponent.self) {
                    visualComponentFloor1.node.run(moveComponentFloor1.setAnimation(sizeX: size.width))
                }
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
