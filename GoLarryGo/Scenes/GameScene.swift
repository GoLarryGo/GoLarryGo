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
    
    lazy var sceneCamera: SKCameraNode = {
        let camera = SKCameraNode()
        camera.setScale(3500)
        return camera
    }()
    
    private var previousUpdateTime: TimeInterval = TimeInterval()
    
    let back = BackgroundEntity()

    var playerControlComponent: PlayerControlComponent? {
        back.component(ofType: PlayerControlComponent.self)
    }
    
    override func didMove(to view: SKView) {
        
        // cria uma instância do gerenciador de entidades
        entityManager = EntityManager(scene: self)
        
        //Camera
        self.camera = sceneCamera
        
        //Nodes
        self.setupNodesPosition()
        
//        //cria a instância background
//        let background = BackgroundEntity()
//        entityManager.add(background)
//        if let visualComponentBackground = background.component(ofType: VisualComponent.self) {
//            visualComponentBackground.node.position = CGPoint(x: size.width/2, y: size.height/2)
//            visualComponentBackground.node.size = CGSize(width: size.width, height: size.height)
//            visualComponentBackground.node.zPosition = -6
//        }
        
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
        

        //cria a instância chão
        let floor = FloorEntity()
        entityManager.add(floor)
        if let visualComponentFloor = floor.component(ofType: VisualComponent.self) {
            visualComponentFloor.node.position = CGPoint(x: frame.minX, y: size.height/2)
            visualComponentFloor.node.size = CGSize(width: size.width, height: size.height)
            visualComponentFloor.node.zPosition = -1
//            if let moveComponentFloor = floor.component(ofType: MoveSceneryComponent.self) {
//                    visualComponentFloor.node.run(moveComponentFloor.setAnimation(sizeX: size.width))
//                }
        }
        
        //cria a instância chão
        let floor1 = FloorEntity()
        entityManager.add(floor1)
        if let visualComponentFloor1 = floor1.component(ofType: VisualComponent.self) {
            visualComponentFloor1.node.position = CGPoint(x: frame.maxX, y: size.height/2)
            visualComponentFloor1.node.size = CGSize(width: size.width, height: size.height)
            visualComponentFloor1.node.zPosition = -1
//            if let moveComponentFloor1 = clouds1.component(ofType: MoveSceneryComponent.self) {
//                    visualComponentFloor1.node.run(moveComponentFloor1.setAnimation(sizeX: size.width))
//                }
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
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
        playerControlComponent?.update(deltaTime: timeSincePreviousUpdate)
        previousUpdateTime = currentTime
        
    }
    
    // MARK: - Adding Nodes to Scene
    func setupNodesPosition() {
        //acessing back from AnimatedSpriteComponents
        guard let backgroundSpriteNode = back.component(ofType: AnimatedSceneryComponent.self)?.spriteNode else {return}

        //positioning knight
        backgroundSpriteNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        backgroundSpriteNode.size = CGSize(width: size.width, height: size.height)
        backgroundSpriteNode.zPosition = -1
  
        self.addChild(backgroundSpriteNode)
    }
}
