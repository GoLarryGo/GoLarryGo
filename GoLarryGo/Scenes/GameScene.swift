//
//  GameScene.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 08/03/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entityManager: EntityManager!
    
    private var previousUpdateTime: TimeInterval = TimeInterval()
    
    let character = CharacterEntity()
    let back = BackgroundEntity()
    let floor = FloorEntity()
    let robot = RobotEntity()
    
    let categoryCharacterPhysic: UInt32 = 1
    let categoryRobotPhysic: UInt32 = 1
    
    var playerControlComponent: PlayerControlComponent? {
        character.component(ofType: PlayerControlComponent.self)
    }
    
    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(jumpTap))
    @objc func jumpTap(_ sender: UITapGestureRecognizer) {
        playerControlComponent?.jump()
    }
    
    override func didMove(to view: SKView) {
        //physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        physicsWorld.contactDelegate = self
        entityManager = EntityManager(scene: self)
        
        view.addGestureRecognizer(tap)
       
        //Nodes
        setupBackNodePosition()
        setupFloorNodePosition()
        setupCharacterNodePosition()
        setupRobotNodePosition()
    }

    override func update(_ currentTime: TimeInterval) {
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
        playerControlComponent?.update(deltaTime: timeSincePreviousUpdate)
        previousUpdateTime = currentTime
        
    }
    
    // MARK: - Adding Nodes to Scene
    func setupBackNodePosition() {
        //acessing back from AnimatedSpriteComponents
        guard let backgroundSpriteNode = back.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}

        //positioning back
        backgroundSpriteNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        backgroundSpriteNode.size = CGSize(width: size.width, height: size.height)
        backgroundSpriteNode.zPosition = -6
  
        self.addChild(backgroundSpriteNode)
    }
    
    func setupFloorNodePosition() {
        //acessing floor from AnimatedSpriteComponents
        guard let floorSpriteNode = floor.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
        
        //positioning floor
        floorSpriteNode.position = CGPoint(x: size.width/2, y: size.height/2)
        floorSpriteNode.size = CGSize(width: size.width, height: size.height)
        floorSpriteNode.zPosition = -1
        
        entityManager.add(floor)
        setupTopFloor()
    }
    
    func setupCharacterNodePosition() {
        //acessing character from AnimatedSpriteComponents
        guard let characterSpriteNode = character.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
        
        //positioning character
        characterSpriteNode.position = CGPoint(x: 50, y: 300)
        characterSpriteNode.size = CGSize(width: 64, height: 64)
        
        characterSpriteNode.physicsBody?.categoryBitMask = categoryCharacterPhysic
        characterSpriteNode.physicsBody?.collisionBitMask = categoryRobotPhysic
        characterSpriteNode.physicsBody?.contactTestBitMask = categoryRobotPhysic
        
        characterSpriteNode.name = "character"
        
        entityManager.add(character)
    }
    
    func setupRobotNodePosition() {
        //acessing character from AnimatedSpriteComponents
        guard let robotSpriteNode = robot.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
        
        //positioning character
        robotSpriteNode.position = CGPoint(x: 400, y: 300)
        robotSpriteNode.size = CGSize(width: 64, height: 64)
        
        robotSpriteNode.physicsBody?.categoryBitMask = categoryRobotPhysic
        robotSpriteNode.physicsBody?.contactTestBitMask = categoryCharacterPhysic
        
        robotSpriteNode.name = "robot"
        
        entityManager.add(robot)
    }
    
    // MARK: - PhysicsBody
    func setupTopFloor() {
        let topFloor = SKSpriteNode()
        topFloor.position = CGPoint(x: size.width/2, y: 30)
        topFloor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: 30))
        topFloor.physicsBody?.isDynamic = false
        addChild(topFloor)
    }
}

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        print("teve contato")
        
        if (contact.bodyA.node?.name == "character" && contact.bodyB.node?.name == "robot")
        || (contact.bodyA.node?.name == "robot" && contact.bodyB.node?.name == "character") {
            playerControlComponent?.dead()
        }
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("acabou contato")
    }
}
