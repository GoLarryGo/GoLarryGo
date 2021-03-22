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
   
    //Floor
    let ground = Ground(numberOfTiles: 120)
    var groundNodes: [SKSpriteNode] = []
    var platformNodes: [SKSpriteNode] = []
    var countPlatform:Int = 1
    
    //Scenery
    var scenery = Scenery()
    var backNode = SKNode()
    var cloundsNode = SKNode()
    var montainFixNode = SKNode()
    var montainAltNode = SKNode()
    var sunNode = SKNode()
    
    //Update
    private var previousUpdateTime: TimeInterval = TimeInterval()

    //game over
    var gameOver: Bool = false
    
    let character = CharacterEntity()
    let robot = RobotEntity()
    
    let categoryCharacterPhysic: UInt32 = 1
    let categoryRobotPhysic: UInt32 = 1
    
    
    var characterPlayerControlComponent: PlayerControlComponent? {
        character.component(ofType: PlayerControlComponent.self)
    }
    
    var robotPlayerControlComponent: PlayerControlComponent? {
        robot.component(ofType: PlayerControlComponent.self)
    }
    
    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(jumpTap))
    @objc func jumpTap(_ sender: UITapGestureRecognizer) {
        guard characterPlayerControlComponent?.stateMachine.currentState?.classForCoder != CharacterJumpState.self else { return }
        characterPlayerControlComponent?.jumpCharacter()
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self
        
        characterPlayerControlComponent?.startCharacter()
        robotPlayerControlComponent?.startRobot()
        
        entityManager = EntityManager(scene: self)
        
        view.addGestureRecognizer(tap)

        //Setups
        setupBackground()
        setupFloorPosition()
        setupCharacterNodePosition()
        setupRobotNodePosition()
        
        //SpeedBackground
        setupSpeed(isDead: true)
        
        //adding move to floor

        for groundNode in groundNodes {
            groundNode.run(scenery.moveScenery(self.size))
        }
        
        let randomPlatforme = SKAction.run {
            let numberXPlatform = Int.random(in: 5..<12)
            self.setupPlatFormPosition(numberTiles: numberXPlatform, positionY: self.getPositionY() )
        }
        self.run(SKAction.repeatForever(SKAction.sequence([randomPlatforme, SKAction.wait(forDuration: 1.5)])))
    }
    
    func getPositionY() -> CGFloat {
        let sequencePositionY: CGFloat = 120
        countPlatform += 1
        if countPlatform % 2 == 0 && countPlatform % 3 != 0 && countPlatform % 5 != 0 {
            return sequencePositionY
        } else if countPlatform % 2 != 0 && countPlatform % 3 == 0 && countPlatform % 5 != 0 {
            return sequencePositionY + 50
        } else if countPlatform % 2 != 0 && countPlatform % 3 != 0 && countPlatform % 5 == 0 {
            return sequencePositionY + 100
        } else if countPlatform % 2 == 0 && countPlatform % 3 == 0 && countPlatform % 5 == 0{
            return sequencePositionY + 150
        } else {
            return sequencePositionY
        }
    }
    
    var activeMoveScenery: Bool = false
    override func update(_ currentTime: TimeInterval) {
        let timeSincePreviousUpdate = currentTime - previousUpdateTime
        characterPlayerControlComponent?.update(deltaTime: timeSincePreviousUpdate)
        previousUpdateTime = currentTime

        if gameOver == true {
            print("Game Over!")
        }
    }

    
    
    func setupSpeed(isDead: Bool) {
        if isDead {
            backNode.speed = 0
            montainFixNode.speed = 0
            montainAltNode.speed = 0
            cloundsNode.speed = 0
        } else {
            backNode.speed = 1
            montainFixNode.speed = 0.5
            montainAltNode.speed = 0.5
            cloundsNode.speed = 1
        }
    }
    
    // MARK: - Adding Nodes to Scene
    func setupBackground() {
        //Scroll background
        var backgroundImage = SKSpriteNode()
                backgroundImage = SKSpriteNode(imageNamed: "back")
                backgroundImage.size = CGSize(width: self.size.width + 10, height: self.size.height)
                backgroundImage.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
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
                montainAltImage.position = CGPoint(x: self.size.width * CGFloat(i), y: 15)
                montainAltImage.run(scenery.moveScenery(self.size))
                montainAltImage.zPosition = ZPositionsCategories.montainAlt
                montainAltNode.addChild(montainAltImage)
            }
        self.addChild(montainAltNode)
        
        //Sun
        var sunImage = SKSpriteNode()
                sunImage = SKSpriteNode(imageNamed: "sun")
                sunImage.anchorPoint = CGPoint(x: 0, y: 0)
                sunImage.size = CGSize(width: self.size.width * 0.15, height: self.size.height * 0.3)
                sunImage.position = CGPoint(x: self.size.width / 2.5 , y: self.size.height / 2)
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
                groundNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: groundNode.size.width * 2, height: groundNode.size.height * 2))
                groundNode.physicsBody?.isDynamic = false
                groundNode.name = "ground"
                groundNodes.append(groundNode)
                self.addChild(groundNode)
            }
    
    }
    
    func setupPlatFormPosition(numberTiles: Int, positionY:CGFloat ) {
        let platform = Platform(numberOfTiles: numberTiles)
        guard let platformTileRowComponent = platform.component(ofType: TileRowComponent.self) else {
            return
        }
        //positioning platform tiles
        let tileCount = platformTileRowComponent.tileNodes.count
        let platformTileNodes: [SKSpriteNode] = platformTileRowComponent.tileNodes.enumerated().map { (index, node) in
                let offset = CGFloat(tileCount/2 - index)
                node.position = CGPoint(
                    x: node.texture!.size().width / 2 * offset + self.size.width,
                    y: positionY
                )
                return node
        }
        //adding nodes to scene
            for platformNode in platformTileNodes {
                platformNode.zPosition = ZPositionsCategories.ground
                platformNode.size = CGSize(width: 32, height: 32)
                platformNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: platformNode.size.width * 2, height: platformNode.size.height * 2))
                platformNode.physicsBody?.isDynamic = false
                platformNode.name = "platform"
                platformNode.run(scenery.movePlatform(self.size))
                platformNodes.append(platformNode)
                self.addChild(platformNode)
            }
    }
    
    func setupCharacterNodePosition() {
        //acessing character from AnimatedSpriteComponents
        guard let characterSpriteNode = character.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
        //positioning character
        characterSpriteNode.position = CGPoint(x: 50, y: 60)
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
        robotSpriteNode.position = CGPoint(x: 800, y: 60)
        robotSpriteNode.size = CGSize(width: 64, height: 64)
        
        robotSpriteNode.physicsBody?.categoryBitMask = categoryRobotPhysic
        robotSpriteNode.physicsBody?.contactTestBitMask = categoryCharacterPhysic
        
        robotSpriteNode.name = "robot"
        
        entityManager.add(robot)
    }
    
    func configureRobotCloneNodePosition(entity: RobotEntity, size: CGSize, position: CGPoint) {
        //acessing character from AnimatedSpriteComponents
        guard let robotSpriteNode = entity.component(ofType: AnimatedSpriteComponent.self)?.spriteNode else {return}
        
        //positioning character
        robotSpriteNode.position = position
        robotSpriteNode.size = size
        
        robotSpriteNode.physicsBody?.categoryBitMask = 2
        robotSpriteNode.physicsBody?.contactTestBitMask = 1
        
        robotSpriteNode.name = "robot"
    }

}

extension GameScene {
    func didBegin(_ contact: SKPhysicsContact) {
        

        if (contact.bodyA.node?.name == "character" && contact.bodyB.node?.name == "robot")
        || (contact.bodyA.node?.name == "robot" && contact.bodyB.node?.name == "character") {
            robotPlayerControlComponent?.deadRobot()
            setupSpeed(isDead: true)
            ScoreView.startGame = false
            gameOver = true
            for groundNode in groundNodes {
                groundNode.removeAllActions()
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        //print("acabou contato")
    }
    
    func stopScenery() {
        setupSpeed(isDead: true)
        gameOver = true
        for groundNode in groundNodes {
            groundNode.removeAllActions()
        }
    }
}
