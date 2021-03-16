//
//  GameScene.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 08/03/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entityManager: EntityManager!
    
    var backNode = SKNode()
    var cloundsNode = SKNode()
    var montainFixNode = SKNode()
    var montainAltNode = SKNode()
    var sunNode = SKNode()
    
    //Floor
    let ground = Ground(numberOfTiles: 120)
    var groundNodes: [SKSpriteNode] = []
    var numberGround = Int.random(in: 3..<16)
    
    var scenery = Scenery()
    
    private var previousUpdateTime: TimeInterval = TimeInterval()
    
    let character = CharacterEntity()
    
    
    var playerControlComponent: PlayerControlComponent? {
        character.component(ofType: PlayerControlComponent.self)
    }
    
    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(jumpTap))
    @objc func jumpTap(_ sender: UITapGestureRecognizer) {
        playerControlComponent?.jump()
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .back
        
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        entityManager = EntityManager(scene: self)
        
        view.addGestureRecognizer(tap)
        
        //Setups
        setupBackground()
        setupFloorPosition()
        setupCharacterNodePosition()
        
        //SpeedBackgroun
        backNode.speed = 1
        montainFixNode.speed = 0.5
        montainAltNode.speed = 0.5
        cloundsNode.speed = 1
        
        //adding move to floor
            for groundNode in groundNodes {
                groundNode.run(scenery.moveGround(self.size))
//                if groundNode.position.x < 0 {
//                    removeFromParent()
//                }
            }
    }

    override func update(_ currentTime: TimeInterval) {
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
        playerControlComponent?.update(deltaTime: timeSincePreviousUpdate)
        previousUpdateTime = currentTime
        
    }
    
    // MARK: - Adding Nodes to Scene
    func setupBackground() {
        //Scroll background
        var backgroundImage = SKSpriteNode()
                backgroundImage = SKSpriteNode(imageNamed: "back")
                backgroundImage.anchorPoint = CGPoint(x: 0, y: 0)
                backgroundImage.size = CGSize(width: self.size.width + 10, height: self.size.height)
                backgroundImage.position = CGPoint(x: self.size.width, y: 0)
                backgroundImage.zPosition = ZPositionsCategories.background
                backNode.addChild(backgroundImage)
        self.addChild(backNode)
        
        //Scrool clounds
        var cloundsImage = SKSpriteNode()
            for i in 0..<2 {
                cloundsImage = SKSpriteNode(imageNamed: "clouds")
                cloundsImage.anchorPoint = CGPoint(x: 0, y: 0)
                cloundsImage.size = CGSize(width: self.size.width, height: self.size.height * 0.35)
                cloundsImage.position = CGPoint(x: self.size.width * CGFloat(i), y: self.size.height * 0.5)
                cloundsImage.run(scenery.moveScenery(self.size))
                cloundsImage.zPosition = ZPositionsCategories.clounds
                cloundsNode.addChild(cloundsImage)
            }
        self.addChild(cloundsNode)
        
        //Scrool montainFix
        var montainFixImage = SKSpriteNode()
            for i in 0..<2 {
                montainFixImage = SKSpriteNode(imageNamed: "montainFix")
                montainFixImage.anchorPoint = CGPoint(x: 0, y: 0)
                montainFixImage.size = CGSize(width: self.size.width, height: self.size.height * 0.4)
                montainFixImage.position = CGPoint(x: self.size.width * CGFloat(i), y: 0)
                montainFixImage.run(scenery.moveScenery(self.size))
                montainFixImage.zPosition = ZPositionsCategories.montainFix
                montainFixNode.addChild(montainFixImage)
            }
        self.addChild(montainFixNode)
        
        //Scrool montainAlt
        var montainAltImage = SKSpriteNode()
            for i in 0..<2 {
                montainAltImage = SKSpriteNode(imageNamed: "montainAlt")
                montainAltImage.anchorPoint = CGPoint(x: 0, y: 0)
                montainAltImage.size = CGSize(width: self.size.width * 0.5, height: self.size.height * 0.5)
                montainAltImage.position = CGPoint(x: self.size.width * CGFloat(i), y: 0)
                montainAltImage.run(scenery.moveScenery(self.size))
                montainAltImage.zPosition = ZPositionsCategories.montainAlt
                montainAltNode.addChild(montainAltImage)
            }
        self.addChild(montainAltNode)
        
        //Scrool sun
        var sunImage = SKSpriteNode()
                sunImage = SKSpriteNode(imageNamed: "sun")
                sunImage.anchorPoint = CGPoint(x: 0, y: 0)
                sunImage.size = CGSize(width: self.size.width * 0.2, height: self.size.height * 0.25)
                sunImage.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
                //sunImage.run(scenery.moveSun(self.size))
                sunImage.zPosition = ZPositionsCategories.sun
                sunNode.addChild(sunImage)
        self.addChild(sunNode)
    }
    
    func setupFloorPosition() {
        guard let groundTileRowComponent = ground.component(ofType: TileRowComponent.self) else {
            return
        }
        //initial positioning ground tiles
        let tileCount = groundTileRowComponent.tileNodes.count
        let groundTileNodes: [SKSpriteNode] = groundTileRowComponent.tileNodes.enumerated().map { (index, node) in
                let offset = CGFloat(tileCount/2 - index)
                node.position = CGPoint(
                    x: node.texture!.size().width / 2 * offset,
                    y: 15
                )
                return node
        }
        //adding nodes to scene
            for groundNode in groundTileNodes {
                groundNode.zPosition = ZPositionsCategories.ground
                groundNode.size = CGSize(width: 32, height: 32)
                groundNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: groundNode.size.width, height: groundNode.size.height))
                groundNode.physicsBody?.isDynamic = false
                groundNode.name = "ground"
                groundNodes.append(groundNode)
                self.addChild(groundNode)
            }
    }
    
    func setupCharacterNodePosition() {
        //acessing character from AnimatedSpriteComponents
        guard let characterSpriteNode = character.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
        //positioning character
        characterSpriteNode.position = CGPoint(x: 50, y: 31)
        characterSpriteNode.size = CGSize(width: 32, height: 32)
        
        entityManager.add(character)
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
